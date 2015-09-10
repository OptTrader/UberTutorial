//
//  AppDelegate.swift
//  UberTutorial
//
//  Created by Chris Kong on 9/10/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import UIKit
import Bolts
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
  {
    Parse.enableLocalDatastore()
    
    Parse.setApplicationId("7fRQojCNILIFl4yNhPr8TXFqJMLOTbBuh1MBSp81",
      clientKey: "alLcCIslz6SE23M0Ui6YzwReMJMEDLz7swpVaswr")
    
    return true
  }

  
}