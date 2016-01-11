//
//  ForecastLocationManager.swift
//  Blue Apron Code Challenge
//
//  Created by Dare Ryan on 1/11/16.
//  Copyright © 2016 co.cordproject. All rights reserved.
//

import CoreLocation
import UIKit

protocol ForecastLocationManagerDelegate {
   func locationManagerDidUpdateLocation(sender: ForecastLocationManager, location: CLLocation)
}

class ForecastLocationManager: NSObject, CLLocationManagerDelegate {

   //MARK: instance variables
   
   private let locationManager = CLLocationManager()
   var delegate:ForecastLocationManagerDelegate?
   
   //MARK: init
   
   override init() {
      super.init()
      setupLocationManager()
   }
   
   //MARK: setup
   
   func setupLocationManager() {
      locationManager.requestWhenInUseAuthorization()
      
      if CLLocationManager.locationServicesEnabled() {
         locationManager.delegate = self
         locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
      }
   }
   
   //MARK: imperatives
   
   func updateCurrentUserLocation() {
      locationManager.startUpdatingLocation()
   }
   
   //MARK: location manager delegate
   
   func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      manager.stopUpdatingLocation()
      
      if let currentLocation = manager.location {
         self.delegate?.locationManagerDidUpdateLocation(self, location: currentLocation)
      }
   }
}
