//
//  Assets.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import UIKit

class Assets{
    static var shared = Assets()
    func getBackground() -> UIImage{
        return UIImage(named: "appBackground")!
    }
    
    func getSearchIcon() -> UIImage{
        return UIImage(named: "searchIcon")!
    }
    func getSettingsIcon() -> UIImage{
        return UIImage(named: "settingsIcon")!
    }
    
    func getMainWeatherDefaultImage() -> UIImage{
        return UIImage(named: "cludy")!
    }
    var forecasts: [Forecast] = [
        Forecast(title: "Rain", icon: "rain", description: "24cm"),
        Forecast(title: "Humidity", icon: "humidity", description: "56%"),
        Forecast(title: "Wind Speed", icon: "wind", description: "12km/H"),
    ]
}
