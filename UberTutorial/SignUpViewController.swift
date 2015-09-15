//
//  SignUpViewController.swift
//  UberTutorial
//
//  Created by Chris Kong on 9/15/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UITextFieldDelegate
{
  var signUpState = true
  
  @IBOutlet weak var username: UITextField!
  @IBOutlet weak var password: UITextField!
  @IBOutlet weak var riderLabel: UILabel!
  @IBOutlet weak var driverLabel: UILabel!
  @IBOutlet weak var `switch`: UISwitch!
  
  @IBAction func signUp(sender: AnyObject)
  {
    if username.text == "" || password.text == ""
    {
      displayAlert("Missing Field(s)", message: "Username and password are required")
    
    } else {
      
      if signUpState == true
      {
        let user = PFUser()
        user.username = username.text
        user.password = password.text
        
        user["isDriver"] = `switch`.on
        
        user.signUpInBackgroundWithBlock{
          (succeeded, error) -> Void in
          if let error = error {
            if let errorString = error.userInfo["error"] as? String
            {
              self.displayAlert("Sign Up Failed", message: errorString)
            }
            
          } else {
            
            print("Sign up successful")
          }
        }
        
      } else {
        
        PFUser.logInWithUsernameInBackground(username.text!, password: password.text!) {
          (user: PFUser?, error: NSError?) -> Void in
          if user != nil
          {
            print("Login successful")
          
          } else {
            if let errorString = error?.userInfo["error"] as? String
            {
              self.displayAlert("Login Failed", message: errorString)
            }
          }
        }
      }
    }
  }
  
  @IBOutlet weak var signUpButton: UIButton!
  
  @IBAction func toggleSignUp(sender: AnyObject)
  {
    if signUpState == true
    {
      signUpButton.setTitle("Login", forState: UIControlState.Normal)
      toggleSignUpButton.setTitle("Switch to Sign Up", forState: UIControlState.Normal)
      signUpState = false
      riderLabel.alpha = 0
      driverLabel.alpha = 0
      `switch`.alpha = 0
    
    } else {
      
      signUpButton.setTitle("Sign Up", forState: UIControlState.Normal)
      toggleSignUpButton.setTitle("Switch to login", forState: UIControlState.Normal)
      signUpState = true
      riderLabel.alpha = 1
      driverLabel.alpha = 1
      `switch`.alpha = 1
    }
    
    
  }
  
  @IBOutlet weak var toggleSignUpButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.username.delegate = self
    self.password.delegate = self
    
    // looks for single or multiple taps
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
    view.addGestureRecognizer(tap)
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