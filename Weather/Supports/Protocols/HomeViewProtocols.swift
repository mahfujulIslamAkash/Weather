//
//  HomeViewProtocols.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import Foundation
import CoreLocation

protocol HomeViewProtocols: AnyObject{
    func tappedOnSearch()
    func selectedCity(name: String, lat: CLLocationDegrees, lon: CLLocationDegrees)
    func pulledRefresh()
    func cameForeground()
    func goingBackground()
    func noInternet()
    func startLoading()
    func endLoading()
}

extension HomeViewProtocols{
    func cameForeground(){}
    func goingBackground(){}
    func noInternet(){}
    func startLoading(){}
    func endLoading(){}
}
