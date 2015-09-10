//
//  SignUpViewController.swift
//  UberTutorial
//
//  Created by Chris Kong on 9/11/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UITextFieldDelegate
{
  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var accountSwitch: UISwitch!
  @IBOutlet weak var riderLabel: UILabel!
  @IBOutlet weak var driverLabel: UILabel!
  @IBOutlet weak var signUpButton: UIButton!
  @IBOutlet weak var toggleSignUpButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.usernameField.delegate = self
    self.passwordField.delegate = self
    
    // looks for single or multiple taps
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
    view.addGestureRecognizer(tap)
    
  }
  
  @IBAction func signUpAction(sender: AnyObject)
  {
    if usernameField.text == "" || passwordField.text == ""
    {
      displayAlert("Missing Field(s)", message: "Username and password are required")
    }
  }
  
  @IBAction func toggleSignUpAction(sender: AnyObject) {
  
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