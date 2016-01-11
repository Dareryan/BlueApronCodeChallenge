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
   
}
