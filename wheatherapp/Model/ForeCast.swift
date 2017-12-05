//
//  ForeCast.swift
//  wheatherapp
//
//  Created by Mirel Spahić on 12/4/17.
//  Copyright © 2017 Mirel Spahić. All rights reserved.
//

import Foundation
import Alamofire

class ForeCast {
    
    private var _day: String!
    private var _weatherType: String!
    private var _minTemp: Double!
    private var _maxTemp: Double!
    
    var day: String! {
        get{
            return _day
        }
        set{
            _day = newValue
        }
    
    }
    
    var weatherType: String!{
        get{
            return _weatherType
        }
        set{
            _weatherType = newValue
        }
        
    }
    
    var minTemp: Double! {
        get{
            return _minTemp
        }
        set{
            _minTemp = newValue
        }
    }
    
    var maxTemp: Double! {
        get{
            return _maxTemp
        }
        set {
            _maxTemp = newValue
        }
    }
    
    static func getForeCasts(completed: @escaping CompletedForeCasts){
        var foreCasts = [ForeCast]()
        
        let currentWeatherUrl = URL(string: FORECAST_WEATHER_URL)!
        print(FORECAST_WEATHER_URL)
        
        Alamofire.request(currentWeatherUrl).responseJSON { response in
            let result = response.result
            print(result)
            
            if let dic = result.value as? Dictionary<String, AnyObject> {
                if let casts = dic["list"] as?  [Dictionary<String, AnyObject>]{
                    for fCast in casts {
                        var newForeCast = ForeCast()
                        
                        if let main = fCast["main"] as? Dictionary<String, AnyObject> {
                            if let temp_min = main["temp_min"] as? Double {
                                let celsiusMin = temp_min - 273.15
                                newForeCast.minTemp = celsiusMin
                            }
                            if let temp_max = main["temp_max"] as? Double {
                                let celsiusMax = temp_max - 273.15
                                newForeCast.maxTemp = celsiusMax
                            }
                        }
                        if let weatherDesc = fCast["weather"] as? [Dictionary<String, AnyObject>] {
                            if let type = weatherDesc[0]["main"] as? String {
                                newForeCast.weatherType = "\(type.capitalized)"
                            }
                            
                        }
                        
                        if let datetime = fCast["dt"] as? Double {
                            let date = Date(timeIntervalSince1970: datetime)
                            
                            //let dateFormatter = DateFormatter()
                            //dateFormatter.dateFormat = "EEEE HH:MM"
                            //dateFormatter.timeStyle = DateFormatter.Style.none //Set time style
                            //dateFormatter.dateStyle = DateFormatter.Style.full //Set date style
                            
                            //dateFormatter.timeZone = TimeZone.current
                            //let localDate = dateFormatter.string(from: date as Date)
                            newForeCast.day = "\(date.dayOfTheWeek().capitalized) h"
                        }
                        
                        print(newForeCast)
                        foreCasts.append(newForeCast)
                    }
                    
                }
                
                completed(foreCasts)
                
            }
        }
    }
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE HH"
        return dateFormatter.string(from: self)
    }
}
