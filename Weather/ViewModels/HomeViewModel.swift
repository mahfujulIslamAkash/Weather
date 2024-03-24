//
//  HomeViewModel.swift
//  Weather
//
//  Created by Appnap Mahfuj on 24/3/24.
//

import Foundation

final class HomeViewModel{
    var weatherResult: ObservableObject<WeatherResult?> = ObservableObject(nil)
    
    func getLocation(){
        LocationService.shared.getLocation(completion: {[weak self] location in
            NetworkService.shared.setLocationData(location: location)
            self?.getWeather()
        })
    }
    
    
    private func getWeather(){
        NetworkService.shared.getWeather(onSuccess: {[weak self] result in
            self?.weatherResult.value = result
        }, onError: {error in
        })
    }
    
    func havingCurrentLocation() -> Bool{
        return NetworkService.shared.havingCurrentLocation()
    }
    func getCityName() -> String?{
        if let cityName = NetworkService.shared.CURRENT_LOCATION?.cityName{
            return cityName
        }else{
            return nil
        }
        
        
    }
    
    func setLocationData(location: MyLocation){
        NetworkService.shared.setLocationData(location: location)
        getWeather()
    }
    
    
}
