//
//  CurrentWeather.swift
//  wheatherapp
//
//  Created by Mirel Spahić on 12/4/17.
//  Copyright © 2017 Mirel Spahić. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from:  Date())
        _date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if (_weatherType == nil){
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete){
        print(CURRENT_WEATHER_URL)
        let currentWeatherUrl = URL(string: CURRENT_WEATHER_URL)!
        
        Alamofire.request(currentWeatherUrl).responseJSON { response in
            let result = response.result
            print(result)
            
            if let dic = result.value as? Dictionary<String, AnyObject> {
                if let name = dic["name"] as? String{
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                
                if let weatherDesc = dic["weather"] as? [Dictionary<String, AnyObject>] {
                    if let type = weatherDesc[0]["main"] as? String {
                        self._weatherType = type.capitalized
                    }
                    print(self._weatherType)
                }
                
                if let main = dic["main"] as? Dictionary<String, AnyObject> {
                    if let temp = main["temp"] as? Double {
                        let celsius = temp - 273.15
                        self._currentTemp = celsius
                    }
                    print(self._currentTemp)
                }
                
                completed()
                
            }
        }
    }

}

