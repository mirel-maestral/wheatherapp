//
//  File.swift
//  wheatherapp
//
//  Created by Mirel Spahić on 12/4/17.
//  Copyright © 2017 Mirel Spahić. All rights reserved.
//

import Foundation
let BASE_FORECAST_URL = "https://api.openweathermap.org/data/2.5/forecast?"
let BASE_URL = "https://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "d784cb9dc9c9fd383ae6b1181261bfd2"

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.Latitude!)\(LONGITUDE)\(Location.sharedInstance.Longitude!)\(APP_ID)\(API_KEY)"
let FORECAST_WEATHER_URL = "\(BASE_FORECAST_URL)\(LATITUDE)\(Location.sharedInstance.Latitude!)\(LONGITUDE)\(Location.sharedInstance.Longitude!)\(APP_ID)\(API_KEY)"


typealias DownloadComplete = () -> ()
typealias CompletedForeCasts = ([ForeCast]) -> ()

