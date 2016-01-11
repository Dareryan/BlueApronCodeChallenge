//
//  OpenWeatherMapAPIClient.swift
//  Blue Apron Code Challenge
//
//  Created by Dare Ryan on 1/11/16.
//  Copyright © 2016 co.cordproject. All rights reserved.
//

import UIKit
import CoreLocation

struct APIConstants {
   static let OpenWeatherMapAPIKey = "56d2b582503c627add53dff05c345c34"
   static let BaseURLString = "http://api.openweathermap.org"
}

class OpenWeatherMapAPIClient: NSObject {
   
   class func forcastForLocation(location: CLLocation, completion:(NSArray?, String?, NSError?) -> Void) {
      let forecastURLPath = "/data/2.5/forecast"
      let forecastURLParameters = "?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&units=imperial&APPID=\(APIConstants.OpenWeatherMapAPIKey)"
      //Append path and parameters to base URL
      let forecastURL = NSURL(string: APIConstants.BaseURLString + forecastURLPath + forecastURLParameters)
      
      let session = NSURLSession.sharedSession()
      session.dataTaskWithURL(forecastURL!) { (data, response, error) -> Void in
         
         guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
            print("error getting meetups: \(error)")
            completion(nil, nil, error)
            return
         }
         
         do {
            let responseDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options:.MutableContainers)
            var cityName = ""
            
            if let forecastCity = responseDictionary["city"] as? NSDictionary {
               let cityNameFromResponseDict = forecastCity["name"] as? String
               cityName = cityNameFromResponseDict == nil ? "" : cityNameFromResponseDict!
            }
            
            let forecastArray = responseDictionary["list"] as? NSArray
            
            completion(forecastArray, cityName, nil)
         }catch let serializationError as NSError {
            print("error serializing JSON: \(serializationError)")
            completion(nil, nil, serializationError)
         }
      }.resume();
   }
   
}

