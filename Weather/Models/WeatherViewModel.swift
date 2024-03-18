//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Appnap Mahfuj on 18/3/24.
//

import Foundation
import UIKit

struct WeatherViewModel: Codable{
    let cityName: String
    let cityLocation: String
    let cityZip: Int
    
    init(cityName: String, cityLocation: String, cityZip: Int) {
        self.cityName = cityName
        self.cityLocation = cityLocation
        self.cityZip = cityZip
    }
    init() {
        self.cityName = "Dhaka"
        self.cityLocation = "12"
        self.cityZip = 1216
    }
    
}

