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
  
  var locationManager: CLLocationManager!
  
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
  
  }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
  {
    let location: CLLocationCoordinate2D = manager.location!.coordinate
    
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