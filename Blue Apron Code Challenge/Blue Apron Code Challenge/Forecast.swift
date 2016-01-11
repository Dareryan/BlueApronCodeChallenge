//
//  Forecast.swift
//  Blue Apron Code Challenge
//
//  Created by Dare Ryan on 1/11/16.
//  Copyright © 2016 co.cordproject. All rights reserved.
//

import UIKit

class Forecast: NSObject {
   
   //MARK: instance variables
   
   private(set) var forecastTime = NSDate()
   private(set) var weatherDescription = ""
   private(set) var weatherIconID = ""
   private(set) var currentTemp = 0.0
   private(set) var minimumTemp = 0.0
   private(set) var maximumTemp = 0.0
   
   //MARK: init
   
   init(responseObject: NSDictionary) {
      //Set forecast time
      if let time = responseObject["dt"] as? Double {
         forecastTime = NSDate(timeIntervalSince1970: time)
      }
      //Set forecast description
      if let weather = responseObject["weather"]?[0] as? NSDictionary {
         if let weatherDescriptionString = weather["description"] as? String {
            weatherDescription = weatherDescriptionString
         }
         
         if let weatherIconIDString = weather["icon"] as? String {
            weatherIconID = weatherIconIDString
         }
      }
      //Set forecast temperatures
      if let weatherParameters = responseObject["main"] as? NSDictionary {
         if let current = weatherParameters["temp"] as? Double {
            currentTemp = current
         }
         
         if let min = weatherParameters["temp_min"] as? Double {
            minimumTemp = min
         }
         
         if let max = weatherParameters["temp_max"] as? Double {
            maximumTemp = max
         }
      }
   }
}
