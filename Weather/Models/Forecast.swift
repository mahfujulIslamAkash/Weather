//
//  TodayForecast.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import Foundation

struct Forecast: Codable{
    let title: String
    let icon: String
    var description: String
    
    init(title: String, icon: String, description: String) {
        self.title = title
        self.icon = icon
        self.description = description
    }
}


