//
//  RiderViewController.swift
//  UberTutorial
//
//  Created by Chris Kong on 9/15/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import UIKit
import Parse
import MapKit

class RiderViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate
{
  @IBOutlet weak var map: MKMapView!
  @IBOutlet weak var callUberButton: UIButton!
  
  var locationManager: CLLocationManager!
  var latitude: CLLocationDegrees = 0
  var longitude: CLLocationDegrees = 0
  var riderRequestActive = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManager = CLLocationManager()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  }
  
  @IBAction func callUber(sender: AnyObject)
  {
    if riderRequestActive == false
    {
      // save to Parse
      
      let riderRequest = PFObject(className: "riderRequest")
      riderRequest["username"] = PFUser.currentUser()?.username
      riderRequest["location"] = PFGeoPoint(latitude: latitude, longitude: longitude)
      
      // TO DO: check to make sure lat and long are not zero
      
      riderRequest.saveInBackgroundWithBlock {
        (succeeded, error) -> Void in
        if (succeeded)
        {
          self.callUberButton.setTitle("Cancel Uber", forState: UIControlState.Normal)
          
        } else {
          
          let alert = UIAlertController(title: "Could not call Uber", message: "Please try again!", preferredStyle: UIAlertControllerStyle.Alert)
          alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
          self.presentViewController(alert, animated: true, completion: nil)
        }
      }
      
      riderRequestActive = true
      
    } else {
      
      self.callUberButton.setTitle("Call An Uber", forState: UIControlState.Normal)
      
      riderRequestActive = false
      
      // query
      
      let query = PFQuery(className:"riderRequest")
      query.whereKey("username", equalTo: PFUser.currentUser()!.username!)
      query.findObjectsInBackgroundWithBlock {
        (objects: [AnyObject]?, error: NSError?) -> Void in
        
        if error == nil
        {
          print("Successfully retrieved \(objects!.count).")
          
          if let objects = objects as? [PFObject]
          {
            for object in objects
            {
              // delete location
              
              object.deleteInBackground()
            }
          }
        } else {
          
          print(error)
        }
      }
    }
  }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
  {
    let location: CLLocationCoordinate2D = manager.location!.coordinate
    self.latitude = location.latitude
    self.longitude = location.longitude
    
    print("locations = \(location.latitude) \(location.longitude)")
    
    let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    self.map.setRegion(region, animated: true)
    
    // remove annotation
    self.map.removeAnnotations(map.annotations)
    
    // add pin
    let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.latitude, location.longitude)
    let objectAnnotation = MKPointAnnotation()
    objectAnnotation.coordinate = pinLocation
    objectAnnotation.title = "Your Location"
    self.map.addAnnotation(objectAnnotation)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == "riderLogout"
    {
      PFUser.logOut()

    }
  }
  
}