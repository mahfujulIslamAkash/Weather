//
//  Support.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import Foundation
import UIKit

class Support{
    static var sheard = Support()
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
}
