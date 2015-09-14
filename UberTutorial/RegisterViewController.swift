//
//  RegisterViewController.swift
//  UberTutorial
//
//  Created by Chris Kong on 9/14/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController, UITextFieldDelegate
{
  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var accountSwitch: UISwitch!
  @IBOutlet weak var riderLabel: UILabel!
  @IBOutlet weak var driverLabel: UILabel!
  @IBOutlet weak var registerButton: UIButton!
  @IBOutlet weak var toggleRegisterButton: UIButton!
  
    override func viewDidLoad() {
      super.viewDidLoad()

      self.usernameField.delegate = self
      self.passwordField.delegate = self
      
      // looks for single or multiple taps
      let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
      view.addGestureRecognizer(tap)
      
    }

  @IBAction func registerAction(sender: AnyObject)
  {
    if usernameField.text == "" || passwordField.text == ""
    {
      displayAlert("Missing Field(s)", message: "Username and password are required")
      
    } else {
      
      let user = PFUser()
      user.username = usernameField.text
      user.password = passwordField.text
      
      user["isDriver"] = accountSwitch.on
      
      user.signUpInBackgroundWithBlock
      {
        (succeeded, error) -> Void in
        if let error = error {
          if let errorString = error.userInfo["error"] as? String
            {
              self.displayAlert("Register Failed", message: errorString)
            }
          
        } else {
          print("Successful")
          // TO DO: segue to other view controller
        }
      }
    }
    
  }
  
  @IBAction func toggleRegisterAction(sender: AnyObject) {
  }
  
  
  
  func displayAlert(title: String, message: String)
  {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
    self.presentViewController(alert, animated: true, completion: nil)
  }
  
  func textFieldShouldReturn(userText: UITextField) -> Bool
  {
    userText.resignFirstResponder()
    return true
  }
  
  // Calls this function when the tap is recognized
  func dismissKeyboard()
  {
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
  }
  
  
}