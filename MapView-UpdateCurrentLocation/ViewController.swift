//
//  ViewController.swift
//  MapView-UpdateCurrentLocation
//
//  Created by Shiju Varghese on 12/08/18.
//  Copyright © 2018 Shiju. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

  @IBOutlet weak var mapView: MKMapView!

  var userPinView: MKAnnotationView!

  override func viewDidLoad() {
    super.viewDidLoad()
   
    mapViewSetUp()
    locationServiceSetUp()
  
  }
  
  //MARK: - MapView SetUp
  private func mapViewSetUp () {
    mapView.showsUserLocation = true
    mapView.showsScale = true
    mapView.showsTraffic = true
    mapView.showsPointsOfInterest = true
    mapView.delegate = self
  }
  
  //MARK: - location Service SetUp
  private func locationServiceSetUp() {
    CoreLocationService.sharedInstance.mapView = mapView
    CoreLocationService.sharedInstance.authorizeUser()
    CoreLocationService.sharedInstance.updateUserLocation()
  }

}


//MARK: - MKMapView Delegate
extension ViewController: MKMapViewDelegate {
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
    //MARK: - Set Custom Image to the User Current Location
    if annotation is MKUserLocation {
      
      let pin = mapView.view(for: annotation) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
      pin.image = #imageLiteral(resourceName: "userImag")
      pin.layer.cornerRadius = pin.frame.size.width/2
      pin.clipsToBounds = true
      userPinView = pin
      return pin
    }
    return nil
  }
  
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    print("Pin Annotation Tap: \(String(describing: view.annotation?.title ?? "No Title"))")
  }
  
}
