/**
 MIT License
 
 Copyright (c) 2017 Alex Nagy
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import Foundation

struct Plist {
  
  let name:String
  
  var sourcePath:String? {
    guard let path = Bundle.main.path(forResource: name, ofType: "plist") else { return .none }
    return path
  }
  
  var destPath:String? {
    guard sourcePath != .none else { return .none }
    let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    return (dir as NSString).appendingPathComponent("\(name).plist")
  }
  
  init?(name:String) {
    
    self.name = name
    
    let fileManager = FileManager.default
    
    guard let source = sourcePath else {
      plistManagerPrint("WARNING: The \(name).plist could not be initialized because it does not exist in the main bundle. Unable to copy file into the Document Directory of the app. Please add a plist file named \(name).plist into the main bundle (your project).")
      return nil }
    guard let destination = destPath else { return nil }
    guard fileManager.fileExists(atPath: source) else {
      plistManagerPrint("The \(name).plist already exist.")
      return nil }
    
    if !fileManager.fileExists(atPath: destination) {
      
      do {
        try fileManager.copyItem(atPath: source, toPath: destination)
      } catch let error as NSError {
        plistManagerPrint("Unable to copy file. ERROR: \(error.localizedDescription)")
        return nil
      }
    }
  }
  
  func getValuesInPlistFile() throws -> NSDictionary? {
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: destPath!) {
      guard let dict = NSDictionary(contentsOfFile: destPath!) else { return .none }
      return dict
    } else {
      throw SwiftyPlistManagerError.fileDoesNotExist
    }
  }
  
  func getMutablePlistFile() -> NSMutableDictionary? {
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: destPath!) {
      guard let dict = NSMutableDictionary(contentsOfFile: destPath!) else { return .none }
      return dict
    } else {
      return .none
    }
  }
  
  func addValuesToPlistFile(dictionary:NSDictionary) throws {
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: destPath!) {
      if !dictionary.write(toFile: destPath!, atomically: false) {
        plistManagerPrint("File not written successfully")
        throw SwiftyPlistManagerError.fileNotWritten
      }
    } else {
      plistManagerPrint("File does not exist")
      throw SwiftyPlistManagerError.fileDoesNotExist
    }
  }

}

public enum SwiftyPlistManagerError: Error {
  case fileNotWritten
  case fileDoesNotExist
  case fileUnavailable
  case fileAlreadyEmpty
  case keyValuePairAlreadyExists
  case keyValuePairDoesNotExist
}

public class SwiftyPlistManager {
  
  public static let shared = SwiftyPlistManager()
  private init() {} //This prevents others from using the default '()' initializer for this class.
  
  var logPlistManager: Bool = false
  
  public func start(plistNames: [String], logging: Bool) {
    
    logPlistManager = logging
    
    plistManagerPrint("Starting SwiftyPlistManager . . .")
    
    var itemCount = 0
    for plistName in plistNames {
      itemCount += 1
      if let _ = Plist(name: plistName) {
        plistManagerPrint("Initialized '\(plistName).plist'")
      }
    }
    
    if itemCount == plistNames.count {
      plistManagerPrint("Initialization complete.")
    }
    
  }
  
  public func addNew(_ value: Any, key: String, toPlistWithName: String, completion:(_ error :SwiftyPlistManagerError?) -> ()) {
    plistManagerPrint("Starting to add value '\(value)' for key '\(key)' to '\(toPlistWithName).plist' . . .")
    if !keyAlreadyExists(key: key, inPlistWithName: toPlistWithName) {
      if let plist = Plist(name: toPlistWithName) {
        
        guard let dict = plist.getMutablePlistFile() else {
          plistManagerPrint("Unable to get '\(toPlistWithName).plist'")
          completion(.fileUnavailable)
          return
        }
        
        dict[key] = value
        
        do {
          try plist.addValuesToPlistFile(dictionary: dict)
          completion(nil)
        } catch {
          plistManagerPrint(error)
          completion(error as? SwiftyPlistManagerError)
        }
        
        logAction(for: plist, withPlistName: toPlistWithName)
        
      } else {
        plistManagerPrint("Unable to get '\(toPlistWithName).plist'")
        completion(.fileUnavailable)
      }
    } else {
      plistManagerPrint("Value for key '\(key)' already exists. Not saving value. Not overwriting value.")
      completion(.keyValuePairAlreadyExists)
    }
    
    
  }
  
  public func removeValueKeyPair(for key: String, fromPlistWithName: String, completion:(_ error :SwiftyPlistManagerError?) -> ()) {
    plistManagerPrint("Starting to remove Key-Value pair for '\(key)' from '\(fromPlistWithName).plist' . . .")
    if keyAlreadyExists(key: key, inPlistWithName: fromPlistWithName) {
      if let plist = Plist(name: fromPlistWithName) {
        
        guard let dict = plist.getMutablePlistFile() else {
          plistManagerPrint("Unable to get '\(fromPlistWithName).plist'")
          completion(.fileUnavailable)
          return
        }
        dict.removeObject(forKey: key)
        
        do {
          try plist.addValuesToPlistFile(dictionary: dict)
          completion(nil)
        } catch {
          plistManagerPrint(error)
          completion(error as? SwiftyPlistManagerError)
        }
        
        logAction(for: plist, withPlistName: fromPlistWithName)
        
      } else {
        plistManagerPrint("Unable to get '\(fromPlistWithName).plist'")
        completion(.fileUnavailable)
      }
    } else {
      plistManagerPrint("Key-Value pair for key '\(key)' does not exists. Remove canceled.")
      completion(.keyValuePairDoesNotExist)
    }
    
  }
  
  public func removeAllKeyValuePairs(fromPlistWithName: String, completion:(_ error :SwiftyPlistManagerError?) -> ()) {
    
    if let plist = Plist(name: fromPlistWithName) {
      
      guard let dict = plist.getMutablePlistFile() else {
        plistManagerPrint("Unable to get '\(fromPlistWithName).plist'")
        completion(.fileUnavailable)
        return
      }
      
      let keys = Array(dict.allKeys)
      
      if keys.count != 0 {
        dict.removeAllObjects()
      } else {
        plistManagerPrint("'\(fromPlistWithName).plist' is already empty. Removal of all key-value pairs canceled.")
        completion(.fileAlreadyEmpty)
        return
      }
      
      do {
        try plist.addValuesToPlistFile(dictionary: dict)
        completion(nil)
      } catch {
        plistManagerPrint(error)
        completion(error as? SwiftyPlistManagerError)
      }
      
      logAction(for: plist, withPlistName: fromPlistWithName)
      
    } else {
      plistManagerPrint("Unable to get '\(fromPlistWithName).plist'")
      completion(.fileUnavailable)
    }
  }
  
  public func save(_ value: Any, forKey: String, toPlistWithName: String, completion:(_ error :SwiftyPlistManagerError?) -> ()) {
    
    if let plist = Plist(name: toPlistWithName) {
      
      guard let dict = plist.getMutablePlistFile() else {
        plistManagerPrint("Unable to get '\(toPlistWithName).plist'")
        completion(.fileUnavailable)
        return
      }
      
      if let dictValue = dict[forKey] {
        
        if type(of: value) != type(of: dictValue){
          plistManagerPrint("WARNING: You are saving a '\(type(of: value))' typed value into a '\(type(of: dictValue))' typed value. Best practice is to save Int values to Int fields, String values to String fields etc. (For example: '_NSContiguousString' to '__NSCFString' is ok too; they are both String types) If you believe that this mismatch in the types of the values is ok and will not break your code than disregard this message.")
        }
        
        dict[forKey] = value
        
      }
      
      do {
        try plist.addValuesToPlistFile(dictionary: dict)
        completion(nil)
      } catch {
        plistManagerPrint(error)
        completion(error as? SwiftyPlistManagerError)
      }
      
      logAction(for: plist, withPlistName: toPlistWithName)
      
    } else {
      plistManagerPrint("Unable to get '\(toPlistWithName).plist'")
      completion(.fileUnavailable)
    }
  }
  
  public func fetchValue(for key: String, fromPlistWithName: String) -> Any? {
    var value:Any?
    
    if let plist = Plist(name: fromPlistWithName) {
      
      guard let dict = plist.getMutablePlistFile() else {
        plistManagerPrint("Unable to get '\(fromPlistWithName).plist'")
        return nil
      }
      
      let keys = Array(dict.allKeys)
      //plistManagerPrint("Keys are: \(keys)")
      
      if keys.count != 0 {
        
        for (_,element) in keys.enumerated() {
          //print("[PlistManager] Key Index - \(index) = \(element)")
          if element as! String == key {
            plistManagerPrint("Found the Value that we were looking for for key: \(key)")
            value = dict[key]! as Any
          } else {
            //print("[PlistManager] This is Item with key '\(element)' and not the Item that we are looking for with key: \(key)")
          }
        }
        
        if value != nil {
          plistManagerPrint("Sending value to completion handler: \(value ?? "Default Value" as Any)")
          return value
        } else {
          plistManagerPrint("WARNING: The Value for key '\(key)' does not exist in '\(fromPlistWithName).plist'! Please, check your spelling.")
          return nil
        }
        
      } else {
        plistManagerPrint("No Value Found in '\(fromPlistWithName).plist' when searching for item with key: \(key). The Plist is Empty!")
        return nil
      }
      
    } else {
      plistManagerPrint("Unable to get '\(fromPlistWithName).plist'")
      return nil
    }
  }
  
  public func getValue(for key: String, fromPlistWithName: String, completion:(_ result : Any?, _ error :SwiftyPlistManagerError?) -> ()) {
    var value:Any?
    
    if let plist = Plist(name: fromPlistWithName) {
      
      guard let dict = plist.getMutablePlistFile() else {
        plistManagerPrint("Unable to get '\(fromPlistWithName).plist'")
        completion(nil, .fileUnavailable)
        return
      }
      
      let keys = Array(dict.allKeys)
      //plistManagerPrint("Keys are: \(keys)")
      
      if keys.count != 0 {
        
        for (_,element) in keys.enumerated() {
          //print("[PlistManager] Key Index - \(index) = \(element)")
          if element as! String == key {
            plistManagerPrint("Found the Value that we were looking for for key: \(key)")
            value = dict[key]! as Any
          } else {
            //print("[PlistManager] This is Item with key '\(element)' and not the Item that we are looking for with key: \(key)")
          }
        }
        
        if value != nil {
          plistManagerPrint("Sending value to completion handler: \(value ?? "Default Value" as Any)")
          completion(value, nil)
        } else {
          plistManagerPrint("WARNING: The Value for key '\(key)' does not exist in '\(fromPlistWithName).plist'! Please, check your spelling.")
          completion(nil, .keyValuePairDoesNotExist)
        }
        
      } else {
        plistManagerPrint("No Value Found in '\(fromPlistWithName).plist' when searching for item with key: \(key). The Plist is Empty!")
        completion(nil, .fileAlreadyEmpty)
      }
      
    } else {
      plistManagerPrint("Unable to get '\(fromPlistWithName).plist'")
      completion(nil, .fileUnavailable)
    }
    
  }
  
  func keyAlreadyExists(key: String, inPlistWithName: String) -> Bool {
    var keyExists = false
    
    if let plist = Plist(name: inPlistWithName) {
      
      guard let dict = plist.getMutablePlistFile() else { return keyExists }
      
      let keys = Array(dict.allKeys)
      //print("[PlistManager] Keys are: \(keys)")
      
      if keys.count != 0 {
        
        for (_,element) in keys.enumerated() {
          
          //print("[PlistManager] Key Index - \(index) = \(element)")
          if element as! String == key {
            plistManagerPrint("Checked if item exists in '\(inPlistWithName).plist' and found it for key: \(key)")
            keyExists = true
          } else {
            //print("[PlistManager] This is Element with key '\(element)' and not the Element that we are looking for with Key: \(key)")
          }
        }
        
      } else {
        keyExists =  false
      }
      
    } else {
      keyExists = false
    }
    
    return keyExists
  }
  
  func logAction(for plist:Plist, withPlistName: String) {
    if logPlistManager {
      
      plistManagerPrint("An Action has been performed. You can check if it went ok by taking a look at the current content of the '\(withPlistName).plist' file: ")
      
      do {
        let plistValues = try plist.getValuesInPlistFile()
        plistManagerPrint("\(plistValues ?? [:])")
      } catch {
        plistManagerPrint("Could not retreive '\(withPlistName).plist' values.")
        plistManagerPrint(error)
      }
      
    }
  }
  
}

func plistManagerPrint(_ text: Any) {
  if SwiftyPlistManager.shared.logPlistManager {
    print("[SwiftyPlistManager]", text)
  }
}


