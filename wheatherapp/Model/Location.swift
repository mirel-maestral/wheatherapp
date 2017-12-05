//
//  Location.swift
//  wheatherapp
//
//  Created by Mirel Spahić on 12/5/17.
//  Copyright © 2017 Mirel Spahić. All rights reserved.
//

import Foundation
import CoreLocation

class Location{
    static var sharedInstance = Location()
    
    private init() {}
    
    var Latitude: Double!
    var Longitude: Double!
}
