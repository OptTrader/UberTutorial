//
//  ViewController.swift
//  UberTutorial
//
//  Created by Chris Kong on 9/10/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController
{
  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var `switch`: UISwitch!
  @IBOutlet weak var riderLabel: UILabel!
  @IBOutlet weak var driverLabel: UILabel!
  @IBOutlet weak var signUpButton: UIButton!
  @IBOutlet weak var toggleSignUpButton: UIButton!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    

    
  }
  
  @IBAction func signUpAction(sender: UIButton) {
    if usernameField.text == "" || passwordField.text == ""
    {
      let alert = UIAlertController(title: "Missing Field(s)", message: "Username and password are required", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
    }
    
  }
  
  @IBAction func toggleSignUpAction(sender: UIButton) {
  
  }


}