//
//  CoreLocationService.swift
//  MapView-UpdateCurrentLocation
//
//  Created by Shiju Varghese on 12/08/18.
//  Copyright © 2018 Shiju. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

final class CoreLocationService: NSObject {
  
  private override init() {}
  static let sharedInstance = CoreLocationService()
  
  let locationManager = CLLocationManager()
  
  var mapView = MKMapView()
  
  //MARK:- Authorize User
  func authorizeUser() {
    
    if CLLocationManager.locationServicesEnabled() {
      
      if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .notDetermined {
        
        locationManager.requestAlwaysAuthorization()
        
      }
      // Update user current location InBackground
      locationManager.allowsBackgroundLocationUpdates = true
      locationManager.pausesLocationUpdatesAutomatically = false
      
      locationManager.desiredAccuracy = kCLLocationAccuracyBest //OR 1.0
      locationManager.delegate = self
      
    }
  }
  
  //MARK:- Update User Location
  func updateUserLocation() {
    locationManager.startUpdatingLocation()
  }

}

//MARK:- CLLocationManager Delegate
extension CoreLocationService: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
    self.mapView.setRegion(region, animated: true)
    self.mapView.userTrackingMode = .followWithHeading
    
    print("Latitude: \(locations[0].coordinate.latitude) -- Longitude: \(locations[0].coordinate.longitude)")
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedAlways {
      // you're good to go!
      print("Status")

    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Unable to access your location.")
  }
  
}

