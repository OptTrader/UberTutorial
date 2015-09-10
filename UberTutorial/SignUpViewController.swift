//
//  SignUpViewController.swift
//  UberTutorial
//
//  Created by Chris Kong on 9/11/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import UIKit

class SignUpViewController: UISearchController
{
  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var accountSwitch: UISwitch!
  @IBOutlet weak var riderLabel: UILabel!
  @IBOutlet weak var driverLabel: UILabel!
  @IBOutlet weak var signUpButton: UIButton!
  @IBOutlet weak var toggleSignUpButton: UIButton!


  @IBAction func signUpAction(sender: AnyObject)
  {
    if usernameField.text == "" || passwordField.text == ""
    {
      let alert = UIAlertController(title: "Missing Field(s)", message: "Username and password are required", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
    }

  }
  @IBAction func toggleSignUpAction(sender: AnyObject) {
  }
    


}