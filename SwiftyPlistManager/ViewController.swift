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

import UIKit
////////////////////////////////////////////////////////////////////////////////////
//
// For a detailed tutorial with images visit:
//
//      http://rebeloper.com/read-write-plist-file-swift/
//
////////////////////////////////////////////////////////////////////////////////////
// First of all drag and drop these 2 helper files into your project:
// MyData.plist
// MySecondPlist.plist
//
////////////////////////////////////////////////////////////////////////////////////
//
// INSTALATION:
// 
// I. CocoaPods:
// 
// 1. run in Terminal on the root of your project: pod init
// 2. add to your Podfile: pod 'SwiftyPlistManager'
// 3. run in Terminal on the root of your project: pod install
// 4. import SwiftyPlistManager by commenting out the line below

//import SwiftyPlistManager

// or II. Manualy:
//
// Drag and drop SwiftyPlistManager.swift into your project
////////////////////////////////////////////////////////////////////////////////////

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    ////////////////////////////////////////////////////////////////////////////////////
    // Now let's start coding!
    // It is always a good practice to make our keys typo-proof
    // Comment out the lines below by deleting the '/*' and '*/'
    // For now don't worry about Xcode complaining about them
    
    /*
    let dataPlistName = "Data"
    let otherDataPlistName = "OtherData"
    let nonExistentPlistName = "NonExistent"
    
    let newKey = "newKey"
    let firstKey = "firstKey"
    let secondKey = "secondKey"
    let thirdKey = "thirdKey"
    let fourthKey = "fourthKey"
    let nonExistentKey = "nonExistentKey"
    
    let helloNewValue = "Hello New Value"
    let rebeloperValue = "Rebeloper"
    let intValue = 17
    let boolValue = true
    let anotherIntValue = 28
    let stringValue = "Alex"
    var dict = ["name": "John", "age": 34] as [String : Any]*/
    
    ////////////////////////////////////////////////////////////////////////////////////
    // Now go to 'Data.plist' and add a new item with this key: 'newKey' and with
    // a String value: 'Hello SwiftyPlistManager'
    // Next let's get some coding done.
    //
    // IMPORTANT: You always have to "start" SwiftyPlistManager on every launch of your app.
    //            Add the next line of code to your 'application(_:didFinishLaunchingWithOptions:)' function 
    //            in Appdelegate.swift
    //
    // For the sake of this tutorial let's just add it here. This is fine too, as long as it is fired on every launch.
    //
    // Set 'logging' to 'true' if you want to log what's going on under the hood. Optionaly set it to 'false'
    // before release or when you are fed up with too much text in the console.
    
    //SwiftyPlistManager.shared.start(plistNames: [dataPlistName], logging: true)
    
    // Bulid & Run. Stop. Never comment back this line of code.
    // What this did is copy your existing Data.plist file into the app's Documents directory.
    // From now on the app will interact with this newly created file and NOT with the plist file you see in Xcode.
    // This is why if you change a value (or add a new item) to your plist now (after the first launch) 
    // than changes will not be reflected in the MyData.plist file you see in Xcode. Instead changes 
    // will be saved to the plist file created in the Documents directory. Consider this Data.plist
    // file (that one you see in Xcode) as a 'starting' file in witch you set up all of your needed 
    // keys with some default values.
    //
    // IMPORTANT: After you first launch your app and than add/remove items in the Data.plist file the changes
    //            will not be reflected in the file in the Documents directory. To add more key-value pairs
    //            to your Data.plist file or change the value of any key-value pair do the following steps:
    //
    //            1. Add your desired new items to the Data.plist file
    //            2. Delete your app from the simulator/device
    //            3. Build & Run the app
    //
    //            You will always have to repeat these steps if you wish to add new key-value pairs through
    //            the Data.plist file. You can easily skip these steps if you add key-value pair through code.
    //            The downside of this is that you can't actually see or edit the key-value pairs in the file
    //            you see in Xcode.
    
    ////////////////////////////////////////////////////////////////////////////////////
    // You can 'start' as many plist files as you'd like as long as you have them in your project bundle already.
    // Of course if the plist does not exist SwiftyPlistManger will gently warn you in the log.
    // Try starting SwiftyPlistManager with these 3 items: "Data", "OtherData" and "NonExistent".
    // Of course, use the constants that you have set up above.
    
    //SwiftyPlistManager.shared.start(plistNames: [dataPlistName, otherDataPlistName, nonExistentPlistName], logging: true)
    
    ////////////////////////////////////////////////////////////////////////////////////
    // Comment the line back again. In this example we will work on the 'Data.plist' file only.
    
    ////////////////////////////////////////////////////////////////////////////////////
    // Let's test if the item with the 'newKey' key exits and print it out in the Log.
    // SwiftyPlistManager uses completion handlers. You'll get back your 'result' as an Any? object.
    // For now let's just check if the error is nil. We'll talk about in depth error handling later on.
    
    /*
    SwiftyPlistManager.shared.getValue(for: newKey, fromPlistWithName: dataPlistName) { (result, err) in
      if err == nil {
        print("-------------------> The Value for Key '\(newKey)' actually exists in the '\(dataPlistName).plist' file. It is: '\(result ?? "No Value Fetched")'")
      }
    }*/
    
    // Hurray! Comment back that call.
    
    ////////////////////////////////////////////////////////////////////////////////////
    // Now let's change the value of this item. We want to avoid the cumbersome 3 step process detailed above, 
    // so we are going to do it in code.
    
    /*
    SwiftyPlistManager.shared.save(helloNewValue, forKey: newKey, toPlistWithName: dataPlistName) { (err) in
      if err == nil {
        print("------------------->  Value '\(helloNewValue)' successfully saved at Key '\(newKey)' into '\(dataPlistName).plist'")
      }
    }*/
    
    // Build & Run. Stop.
    // Note that you don't see any changes in the Data.plist file. This is how it should be, because the app
    // saved the new value to the file in the Documents directory, remember? So now let's get back the changed
    // value. Comment out the call below.
    
    /*
    SwiftyPlistManager.shared.getValue(for: newKey, fromPlistWithName: dataPlistName) { (result, err) in
      if err == nil {
        print("-------------> The Value for Key '\(newKey)' actually exists. It is: '\(result!)'")
      }
    }*/
    
    // Build & Run and take a look at the Log. Stop. Comment back the lines from above.
    // Note that the value you get back is an optional. Retreiveng it with the 'bang operator' (!) is quite risky
    // because you might get back nil and that would crash your app! My suggestion is to never ever use the 
    // 'bang operator'. It's risky, crash-prone and shouts that you are a lazy, clueless (or both) developer.
    // There are better ways to write code. For a strt let's add a default value.
    
    /*
    SwiftyPlistManager.shared.getValue(for: newKey, fromPlistWithName: dataPlistName) { (result, err) in
      if err == nil {
        print("-------------> The Value for Key '\(newKey)' actually exists. It is: '\(result ?? "No Value")'")
      }
    }*/

    
    // Build & Run and take a look at the Log. Stop. Comment back the lines from above.
    // At this point the optional value will default to the "No Value" Sting. I personally hate working with default
    // values because they might pop up and would ruin the user experience of any app. To enhance your code let's 
    // unwrap the 'result' with a guard-let statement.
    
    /*
    SwiftyPlistManager.shared.getValue(for: newKey, fromPlistWithName: dataPlistName) { (result, err) in
      if err == nil {
        guard let result = result else {
          print("-------------> The Value for Key '\(newKey)' does not exists.")
          return
        }
        print("-------------> The Value for Key '\(newKey)' actually exists. It is: '\(result)'")
      }
    }*/
    
    // Or you can unwrap it with an if-let satement if you do not wish to return from the completion handler right away
    
    /*
    SwiftyPlistManager.shared.getValue(for: newKey, fromPlistWithName: dataPlistName) { (result, err) in
      if err == nil {
        
        if let result = result {
          print("-------------> The Value for Key '\(newKey)' actually exists. It is: '\(result)'")
        } else {
          print("-------------> The Value for Key '\(newKey)' does not exists.")
        }
        
        print("-------------> This line will be printed out regardless if the Value for Key '\(newKey)' exists or not.")
        
      }
    }*/
    
    // Congratulations! You have learned how and when to use (or not to use) the 'bang operator', 'guard-let statements'
    // and 'if-let' statements. You now have solid knowledge of how to deal with optionals.
    
    // Most of the times you want to cast yor result into a constant right away and not wait for the 
    // completion handler to finish. You can use the following call to do just that. For this example we'll
    // unwrap it with a guard-let statement.
    
    /*
    guard let fetchedValue = SwiftyPlistManager.shared.fetchValue(for: newKey, fromPlistWithName: dataPlistName) else { return }
    print("-------------> The Fetched Value for Key '\(newKey)' actually exists. It is: '\(fetchedValue)'")*/
    
    ////////////////////////////////////////////////////////////////////////////////////
    // Of course if you try to fetch a value with a non-existent key, 'SwiftyPlistManager' has your back.
    // It will show a WARNING in the log that the key does not exist AND it will not crash the app. Sweet!
    
    /*
    guard let nonExistentValue = SwiftyPlistManager.shared.fetchValue(for: nonExistentKey, fromPlistWithName: dataPlistName) else {
      print("-------------> The Value does not exist so going to return now!")
      return
    }
    print("-------------> This line will never be executed because the Key is: '\(nonExistentKey)' so the Value is '\(nonExistentValue)'")*/
    
    ////////////////////////////////////////////////////////////////////////////////////
    // Now let's take a look at some other awesome powers that come with SwiftyPlistManager.
    // You can add a new key-value pair like so:
    
    /*
    SwiftyPlistManager.shared.addNew(rebeloperValue, key: firstKey, toPlistWithName: dataPlistName) { (err) in
      if err == nil {
        print("-------------> Value '\(rebeloperValue)' successfully added at Key '\(firstKey)' into '\(dataPlistName).plist'")
      }
    }*/
    
    // Now Build & Run your project... Congratulations! You have just created and saved your first key-value pair into your plist file. Stop the project from running.
    
    ////////////////////////////////////////////////////////////////////////////////////
    // Now add a next value with an Int
    
    /*
    SwiftyPlistManager.shared.addNew(intValue, key: secondKey, toPlistWithName: dataPlistName) { (err) in
      if err == nil {
        print("-------------> Value '\(intValue)' successfully added at Key '\(secondKey)' into '\(dataPlistName).plist'")
      }
    }*/
    
    // Build  & Run again. Take a look at your progress in the Log. Stop.
    
    ////////////////////////////////////////////////////////////////////////////////////
    // And finally add an item that has a Bool value
    
    /*
    SwiftyPlistManager.shared.addNew(boolValue, key: thirdKey, toPlistWithName: dataPlistName) { (err) in
      if err == nil {
        print("-------------> Value '\(boolValue)' successfully added at Key '\(thirdKey)' into '\(dataPlistName).plist'")
      }
    }*/
    
    // Build & Run again. Take a look at your progress in the Log. Notice that 'true' is represented
    // with a '1' and 'false' is represented with a '0'. Stop your project from running.
    // As in real life examples you just can't comment out these 3 calls after the first launch of the
    // app, but you don't have to. 'SwiftyPlistManager' takes care of not creating a new item for the same key.
    // Do not comment out this last call and Build & Run again. Take a look at the Log.
    
    ////////////////////////////////////////////////////////////////////////////////////
    
    // Remember, you don't have to add your items through code at all.
    // You can add them into the Data.plist file; it's much easier, but it has a downside:
    // Once you run and test your code for the first time you cannot add or delete any entries using the plist file.
    // Changes made will not be reflected. You will have to delete your app from the simulator,
    // Clean your project (Product/Clean) and Build & Run again to see your changes. However adding/saving/deleting will
    // work when done in code.
    
    ////////////////////////////////////////////////////////////////////////////////////
    // Great! So now you know that 'adding' a new key-value pair is not the same as 'updating'/'saving a new value'
    // for a key. Let's do that now.
    // Change and at the same time Save the second key's value to '28' (anotherIntValue)
    
    /*
    SwiftyPlistManager.shared.save(anotherIntValue, forKey: secondKey, toPlistWithName: dataPlistName) { (err) in
      if err == nil {
        print("-------------> Value '\(anotherIntValue)' successfully saved at Key '\(secondKey)' into '\(dataPlistName).plist'")
      }
    }*/
    
    // Of course, Build & Run again. And after you take a look at your progress. Stop.
    // And comment back the line. From now on do it on every new task. :)
    // Awesome!
    
    ////////////////////////////////////////////////////////////////////////////////////
    // 'SwiftyPlistManager' is Semi Type Safe. What this means is that for example if you try to save
    // a String value for a non-String value, let's say to save 'Alex' (stringValue) for the 'thirdKey'
    // witch already has a Bool value, than 'SwiftyPlistManager' will give you a Warning but let you
    // make the save anyway. It is your responsibility that you save the right types of values. Try it out.
    
    /*
    SwiftyPlistManager.shared.save(stringValue, forKey: thirdKey, toPlistWithName: dataPlistName) { (err) in
      if err == nil {
        print("-------------> Value '\(stringValue)' successfully saved at Key '\(thirdKey)' into '\(dataPlistName).plist'")
      }
    }*/
    
    ////////////////////////////////////////////////////////////////////////////////////
    // Better change back the value to a Bool for the Item with key 'thirdKey' before you forget it.
    
    /*
    SwiftyPlistManager.shared.save(boolValue, forKey: thirdKey, toPlistWithName: dataPlistName) { (err) in
      if err == nil {
        print("-------------> Value '\(boolValue)' successfully saved at Key '\(thirdKey)' into '\(dataPlistName).plist'")
      }
    }*/
    
    // The warning will come up this time too, but now you know that it is set back the way you need it.
    
    ////////////////////////////////////////////////////////////////////////////////////
    // Of course, you may add Dictionaries, Arrays, Dates and Data items too. Try it out
    // by adding a new dictionary.
    
    /*
    SwiftyPlistManager.shared.addNew(dict, key: fourthKey, toPlistWithName: dataPlistName) { (err) in
      if err == nil {
        print("-------------> Value '\(dict)' successfully saved at Key '\(fourthKey)' into '\(dataPlistName).plist'")
      }
    }*/
    
    ////////////////////////////////////////////////////////////////////////////////////
    // Now just to have some fun with it, change the age of John to 56.
    
    /*
    dict["age"] = 56
    SwiftyPlistManager.shared.save(dict, forKey: fourthKey, toPlistWithName: dataPlistName) { (err) in
      if err == nil {
        print("-------------> Value '\(dict)' successfully saved at Key '\(fourthKey)' into '\(dataPlistName).plist'")
      }
    }*/
    
    // Well done! Now comment back the calls.
    
    ////////////////////////////////////////////////////////////////////////////////////
    // Once in a while you might want to remove a value-key pair
    
    /*
    SwiftyPlistManager.shared.removeValueKeyPair(for: thirdKey, fromPlistWithName: dataPlistName) { (err) in
      if err == nil {
        print("-------------> Key-Value pair successfully removed at Key '\(thirdKey)' from '\(dataPlistName).plist'")
      }
    }*/
    
    // Of course, if this line is executed several times 'SwiftyPlistManager' realises that the item
    // was already removed and does not exist. Try it out!
    
    ////////////////////////////////////////////////////////////////////////////////////
    // Or you might want to delete all the data from your plist file
    
    /*
    SwiftyPlistManager.shared.removeAllKeyValuePairs(fromPlistWithName: dataPlistName) { (err) in
      if err == nil {
        print("-------------> Successfully removed all Key-Value pairs from '\(dataPlistName).plist'")
      }
    }*/
    
    // Of course, if this line is executed several times 'SwiftyPlistManager' realises that the plist
    // is empty and cancels the operation. Try it out.
    
    ////////////////////////////////////////////////////////////////////////////////////
    
    // Remember: Your plist file is saved and updated inside the application's Documents folder
    // This is why you will not see any changes at all in the MyData.plist file that you see in the
    // Xcode project. That file is there as a 'starter' file. Once you start the app and make
    // the 'startPlistManager()' call a copy is created in the app's Documents folder and from that new file is used
    // for all your data till you delete your app from simulator/device and Clean (Product/Clean) your project.
    
    ////////////////////////////////////////////////////////////////////////////////////
    // Let's talk about error-handling. When performing calls with 'SwiftyPlistManager' you get access 
    // to possible errors in the completion handlers. Let's dive deep into learning all about them.
    //
    // For a start let's write a function that interprets the error types you might get. We will simply log the error, 
    // but you can do whatever you want.
    
    /*
    func logSwiftyPlistManager(_ error: SwiftyPlistManagerError?) {
      guard let err = error else {
        return
      }
      print("-------------> SwiftyPlistManager error: '\(err)'")
    }*/
    
    ////////////////////////////////////////////////////////////////////////////////////
    // Now let's take a look at the most common use cases and their errors
    ////////////////////////////////////////////////////////////////////////////////////
    // fileUnavailable
    
    /*
    SwiftyPlistManager.shared.addNew(helloNewValue, key: newKey, toPlistWithName: nonExistentPlistName) { (err) in
      if err != nil {
        logSwiftyPlistManager(err)
      }
    }*/
    
    ////////////////////////////////////////////////////////////////////////////////////
    // fileAlreadyEmpty
    
    /*
    SwiftyPlistManager.shared.removeAllKeyValuePairs(fromPlistWithName: dataPlistName) { (err) in
      if err != nil {
        logSwiftyPlistManager(err)
      }
    }*/
    
    ////////////////////////////////////////////////////////////////////////////////////
    // keyValuePairAlreadyExists
    
    /*
    SwiftyPlistManager.shared.addNew(rebeloperValue, key: firstKey, toPlistWithName: dataPlistName) { (err) in
      if err != nil {
        logSwiftyPlistManager(err)
      } else {
        print("-------------> Value '\(rebeloperValue)' successfully added at Key '\(firstKey)' into '\(dataPlistName).plist'")
      }
    }
    
    SwiftyPlistManager.shared.addNew(rebeloperValue, key: firstKey, toPlistWithName: dataPlistName) { (err) in
      if err != nil {
        logSwiftyPlistManager(err)
      }
    }*/
    
    ////////////////////////////////////////////////////////////////////////////////////
    // keyValuePairDoesNotExist
    
    /*
    SwiftyPlistManager.shared.getValue(for: nonExistentKey, fromPlistWithName: dataPlistName) { (result, err) in
      if err != nil {
        logSwiftyPlistManager(err)
      }
    }*/
    
    ////////////////////////////////////////////////////////////////////////////////////
 
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

