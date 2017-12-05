//
//  ViewController.swift
//  wheatherapp
//
//  Created by Mirel Spahić on 11/30/17.
//  Copyright © 2017 Mirel Spahić. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    
    var currentWeather: CurrentWeather!
    var foreCasts: [ForeCast]!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        currentWeather = CurrentWeather()
        foreCasts = [ForeCast]()
        
        
    }
    
    func getData() {
        
        currentWeather.downloadWeatherDetails(completed: self.updateMainUI)
        
        ForeCast.getForeCasts { (fs) in
            self.foreCasts = fs
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foreCasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? ForeCastCell{
            let fs = foreCasts[indexPath.row]
            cell.maxTemp.text = "\(Double(round(fs.maxTemp!)))"
            cell.minTemp.text = "\(Double(round(fs.minTemp!)))"
            cell.day.text = fs.day
            cell.weatherType.text = fs.weatherType
            cell.weatherImage.image = UIImage(named: fs.weatherType)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func updateMainUI() {
        
        currentTempLabel.text = "\(currentWeather.currentTemp.rounded())°"
        currentLocationLabel.text = currentWeather.cityName
        currentWeatherLabel.text = currentWeather.weatherType
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType == "Mist" ? "Partially Cloudy Copy" : currentWeather.weatherType)
        dataLabel.text = currentWeather.date
        
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.Latitude = currentLocation?.coordinate.latitude
            Location.sharedInstance.Longitude = currentLocation?.coordinate.longitude
        }else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
        getData()
    }
}

