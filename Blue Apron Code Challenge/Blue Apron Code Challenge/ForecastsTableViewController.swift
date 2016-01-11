//
//  ForecastsTableViewController.swift
//  Blue Apron Code Challenge
//
//  Created by Dare Ryan on 1/11/16.
//  Copyright © 2016 co.cordproject. All rights reserved.
//

import UIKit

class ForecastsTableViewController: UITableViewController, ForecastDataSourceDelegate {
   
   let dataSource = ForecastDataSource()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setupTableView()
      setupDataSource()
   }
   
   func setupTableView() {
      tableView.registerNib(UINib(nibName: "ForecastTableViewCell", bundle: nil), forCellReuseIdentifier: ForecastTableViewCell.reuseIdentifier())
   }
   
   func setupDataSource () {
      dataSource.delegate = self
      dataSource.reload()
   }
   
   // MARK: - Table view data source
   
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return dataSource.numberOfSections()
   }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return dataSource.numberOfRowsInSection(section)
   }
   
   func forecastDataSourceDidLoad(dataSource: ForecastDataSource) {
      dispatch_async(dispatch_get_main_queue()) { () -> Void in
         self.tableView.reloadData()
      }
   }
   
   override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return dataSource.titleForSection(section)
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier(ForecastTableViewCell.reuseIdentifier(), forIndexPath: indexPath) as! ForecastTableViewCell
      
      let forecast = dataSource.forecastForIndexPath(indexPath)
      let forecastTime = dataSource.generateForecastTimeStamp(forecast.forecastTime)
      let forecastCity = dataSource.cityName
      let forecastDescription = forecast.weatherDescription
      let forecastTemp = String(format: "%.1f˚F", forecast.currentTemp)
      let forecastMin = String(format: "%.1f˚F", forecast.minimumTemp)
      let forecastMax = String(format: "%.1f˚F", forecast.maximumTemp)
      var forecastIcon: UIImage
      if let icon = UIImage(named: forecast.weatherIconID) {
         forecastIcon = icon
      }else{
         //Default to sun image in case of error
         forecastIcon = UIImage(named: "01d")!
      }
      
      cell.configureWithForecastData(forecastTime, city: forecastCity, description: forecastDescription, image: forecastIcon, temp: forecastTemp, high: forecastMax, low: forecastMin)
      
      return cell
   }
   
   override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
      return ForecastTableViewCell.cellHeight()
   }
   
}
