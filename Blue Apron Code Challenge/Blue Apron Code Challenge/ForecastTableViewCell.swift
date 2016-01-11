//
//  ForecastTableViewCell.swift
//  Blue Apron Code Challenge
//
//  Created by Dare Ryan on 1/11/16.
//  Copyright © 2016 co.cordproject. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
   
   //MARK: instance variables
   
   @IBOutlet weak var timeLabel: UILabel!
   @IBOutlet weak var cityLabel: UILabel!
   @IBOutlet weak var descriptionLabel: UILabel!
   @IBOutlet weak var weatherImageView: UIImageView!
   @IBOutlet weak var currentTempLabel: UILabel!
   @IBOutlet weak var highTempLabel: UILabel!
   @IBOutlet weak var lowTempLabel: UILabel!
   
   func configureWithForecastData(time: String, city: String, description: String, image: UIImage, temp: String, high: String, low: String) {
      timeLabel.text = time
      cityLabel.text = city
      descriptionLabel.text = description
      weatherImageView.image = image
      currentTempLabel.text = temp
      highTempLabel.text = high
      lowTempLabel.text = low
   }
   
   //MARK: accessors
   
   class func cellHeight() -> CGFloat {
      return 90.0
   }
   
   class func reuseIdentifier() -> String {
      return "ForecastTableViewCell"
   }
}

