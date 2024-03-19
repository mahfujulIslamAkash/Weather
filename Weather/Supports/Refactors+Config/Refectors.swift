//
//  Refectors.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import Foundation

enum AlertMessage{
    case noInternet
    case permission
    
    var title: String{
        switch self {
        case .noInternet:
            return "No Internet Connection"
        case .permission:
            return "Allow Access"
        }
    }
    
    var description: String{
        switch self{
        case .noInternet:
            return "App don't have internet connection, Please collect!"
        case .permission:
            return "App don't have location permission, Please permit first!"
        }
    }
}
