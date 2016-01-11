//
//  ForecastDataSource.swift
//  Blue Apron Code Challenge
//
//  Created by Dare Ryan on 1/11/16.
//  Copyright © 2016 co.cordproject. All rights reserved.
//

import UIKit
import CoreLocation

protocol ForecastDataSourceDelegate {
   func forecastDataSourceDidLoad(dataSource: ForecastDataSource)
}

class ForecastDataSource: NSObject, ForecastLocationManagerDelegate {
   
   //MARK: instance variables
   
   var forecastDateDictionary = [String : Array<Forecast>]()
   var sectionKeys = Array<String>()
   var cityName = ""
   let locationManager = ForecastLocationManager()
   var delegate:ForecastDataSourceDelegate?
   let forecastTimeFormatter = NSDateFormatter()
   
   //MARK: init
   
   override init() {
      super.init()
      setupLocationManager()
   }
   
   //MARK: setup
   
   func setupLocationManager() {
      locationManager.delegate = self;
   }
   
   //MARK: imperatives
   
   func reload() {
      forecastDateDictionary = [:]
      sectionKeys = []
      locationManager.updateCurrentUserLocation()
   }
   
   func getForecastForLocation(location: CLLocation) {
      OpenWeatherMapAPIClient.forcastForLocation(location) { (response, city, error) -> Void in
         if error != nil {return}
         
         self.cityName = city != nil ? city! : ""
         
         var weatherForecasts = Array<Forecast>()
         if let forecastsResponseArray = response {
            for dictionary in forecastsResponseArray {
               if let forecastDictionary = dictionary as? NSDictionary {
                  weatherForecasts.append(Forecast(responseObject: forecastDictionary))
               }
            }
         }
         let forecastData = self.newForecastDataFromForecasts(weatherForecasts)
         self.forecastDateDictionary = forecastData.forecastDictionary
         self.sectionKeys = forecastData.dictionaryDateKeys
         self.delegate?.forecastDataSourceDidLoad(self)
      }
   }
   
   //MARK: accessors
   
   func titleForSection(section: Int) -> String {
      return sectionKeys[section]
   }
   
   func forecastForIndexPath(ip: NSIndexPath) -> Forecast{
      let sectionKey = sectionKeys[ip.section]
      return forecastDateDictionary[sectionKey]![ip.row]
   }
   
   func numberOfSections() -> Int {
      return forecastDateDictionary.keys.count
   }
   
   func numberOfRowsInSection(section: Int) -> Int {
      let key = sectionKeys[section]
      return forecastDateDictionary[key]!.count
   }
   
   func locationManagerDidUpdateLocation(sender: ForecastLocationManager, location: CLLocation) {
      getForecastForLocation(location)
   }
   
   //MARK: factories
   
   func newForecastDataFromForecasts(forecasts: Array<Forecast>) -> (forecastDictionary: Dictionary<String, Array<Forecast>>, dictionaryDateKeys: Array<String>) {
      var weatherDictionary = [String : Array<Forecast>]()
      var dictionaryKeys = Array<String>()
      for forecast in forecasts {
         let dateKey = generateForecastDateKey(forecast.forecastTime)
         if weatherDictionary[dateKey] != nil {
            weatherDictionary[dateKey]!.append(forecast)
         }else{
            dictionaryKeys.append(dateKey)
            weatherDictionary[dateKey] = [forecast]
         }
      }
      return (weatherDictionary, dictionaryKeys)
   }
   
   func generateForecastDateKey(forecastDate: NSDate) -> String {
      forecastTimeFormatter.dateFormat = "MMMM dd"
      return forecastTimeFormatter.stringFromDate(forecastDate)
   }
   
   func generateForecastTimeStamp(forecastDate: NSDate) -> String {
      forecastTimeFormatter.dateFormat = "hh:mm a"
      return forecastTimeFormatter.stringFromDate(forecastDate)
   }
   
}
