//
//  RequestViewController.swift
//  UberTutorial
//
//  Created by Chris Kong on 9/16/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import UIKit
import Parse
import MapKit

class RequestViewController: UIViewController, CLLocationManagerDelegate
{
  @IBOutlet weak var map: MKMapView!
  
  var requestLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
  var requestUserName: String = ""

  override func viewDidLoad() {
    super.viewDidLoad()
    
    print(requestUserName)
    print(requestLocation)
    
    let region = MKCoordinateRegion(center: requestLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    self.map.setRegion(region, animated: true)
    
    // add pin
    let objectAnnotation = MKPointAnnotation()
    objectAnnotation.coordinate = requestLocation
    objectAnnotation.title = requestUserName
    self.map.addAnnotation(objectAnnotation)
    
  }
  
  @IBAction func pickUpRiderAction(sender: AnyObject)
  {
    let query = PFQuery(className:"riderRequest")
    query.whereKey("username", equalTo: requestUserName)
    query.findObjectsInBackgroundWithBlock {
      (objects: [AnyObject]?, error: NSError?) -> Void in
      
      if error == nil
      {
        if let objects = objects as? [PFObject]
        {
          for object in objects
          {
            let query = PFQuery(className:"riderRequest")
            query.getObjectInBackgroundWithId(object.objectId!) {
              (object: PFObject?, error: NSError?) -> Void in
              if error != nil
              {
                print(error)
              
              } else if let object = object
              {
                object["driverResponded"] = PFUser.currentUser()!.username!
                object.saveInBackground()
                
                let requestCLLocation = CLLocation(latitude: self.requestLocation.latitude, longitude: self.requestLocation.longitude)
                
                CLGeocoder().reverseGeocodeLocation(requestCLLocation, completionHandler: { (placemarks, error) -> Void in
                  if (error != nil)
                  {
                    print(error!)
                  
                  } else {
                    if placemarks!.count > 0
                    {
                      // create placemark
                      
                      let pm = placemarks![0] 
                      
                      let mkPm = MKPlacemark(placemark: pm)
                      
                      let mapItem = MKMapItem(placemark: mkPm)
                      
                      mapItem.name = self.requestUserName
                      
                      let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                      
                      mapItem.openInMapsWithLaunchOptions(launchOptions)
                    
                    } else {
                      
                      print("Problem with the data received from geocoder")
                    }
                  }
                })

                
              }
            }
          }
        }
      } else {
        
        print(error)
      }
    }
  }
  
  
}