//
//  City.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import Foundation
import CoreLocation

struct CityModel: Codable{
    var name: String
    var lat: CLLocationDegrees
    var lon: CLLocationDegrees
    
    init(name: String = "Dhaka", lat: CLLocationDegrees = 23.7278453, lon: CLLocationDegrees = 90.4077583) {
        self.name = name
        self.lat = lat
        self.lon = lon
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.lat = try container.decode(CLLocationDegrees.self, forKey: .lat)
        self.lon = try container.decode(CLLocationDegrees.self, forKey: .lon)
    }
    
    
}
