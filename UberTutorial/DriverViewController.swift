//
//  DriverViewController.swift
//  UberTutorial
//
//  Created by Chris Kong on 9/16/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import UIKit
import Parse
import MapKit

class DriverViewController: UITableViewController, CLLocationManagerDelegate
{
  // driver's location
  
  var locationManager: CLLocationManager!
  var latitude: CLLocationDegrees = 0
  var longitude: CLLocationDegrees = 0
  
  // array of riders' data
  
  var usernames = [String]()
  var locations = [CLLocationCoordinate2D]()
  var distances = [CLLocationDistance]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManager = CLLocationManager()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    
    

  }

  // MARK: - Methods
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
  {
    let location: CLLocationCoordinate2D = manager.location!.coordinate
    self.latitude = location.latitude
    self.longitude = location.longitude
    
    print("locations = \(location.latitude) \(location.longitude)")
    
    // create query function
    
    let query = PFQuery(className:"riderRequest")
    query.whereKey("location", nearGeoPoint: PFGeoPoint(latitude: location.latitude, longitude: location.longitude))
    query.limit = 10
    query.findObjectsInBackgroundWithBlock {
      (objects: [AnyObject]?, error: NSError?) -> Void in
      
      if error == nil
      {
        print("Successfully retrieved \(objects!.count).")
        
        if let objects = objects as? [PFObject]
        {
          // remove existing data
          
          self.usernames.removeAll()
          self.locations.removeAll()
          
          for object in objects
          {
            if let username = object["username"] as? String
            {
              self.usernames.append(username)
            }
            
            if let returnedLocation = object["location"] as? PFGeoPoint
            {
              let requestLocation = CLLocationCoordinate2DMake(returnedLocation.latitude, returnedLocation.longitude)
              
              self.locations.append(requestLocation)
              // self.locations.append(CLLocationCoordinate2DMake(location.latitude, location.longitude))
              
              let requestCLLocation = CLLocation(latitude: requestLocation.latitude, longitude: requestLocation.longitude)
              
              let driverCLLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
              
              let distance = driverCLLocation.distanceFromLocation(requestCLLocation)
              
              self.distances.append(distance / 1000)
            }
            
          }
          self.tableView.reloadData()
          
          print(self.locations)
          print(self.usernames)
        }
      } else {
        
        print(error)
      }
    }
    
//    
//    
//    let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
//    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//    
//    //self.map.setRegion(region, animated: true)
//    
//    // remove annotation
//    //self.map.removeAnnotations(map.annotations)
//    
//    // add pin
//    let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.latitude, location.longitude)
//    let objectAnnotation = MKPointAnnotation()
//    objectAnnotation.coordinate = pinLocation
//    objectAnnotation.title = "Your Location"
//    //self.map.addAnnotation(objectAnnotation)
  }
  

  // MARK: - Table view data source

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return usernames.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    
    let distanceDouble = Double(distances[indexPath.row])
    
    let roundedDistance = Double(round(distanceDouble * 10) / 10)
    
    // TO DO: reformat number and convert to miles
    
    // cell.textLabel?.text = usernames[indexPath.row] + String(locations[indexPath.row].latitude)
    // cell.textLabel?.text = usernames[indexPath.row] + " - " + String(distances[indexPath.row]) + "km away"
    cell.textLabel?.text = usernames[indexPath.row] + " - " + String(roundedDistance) + "km away"
    
    return cell
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == "driverLogout"
    {
      navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: false)
      PFUser.logOut()
    }
  }
 

}