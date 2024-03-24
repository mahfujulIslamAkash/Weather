//
//  HomeViewModel.swift
//  Weather
//
//  Created by Appnap Mahfuj on 24/3/24.
//

import Foundation

final class HomeViewModel{
    var WeatherResult: ObservableObject<WeatherResult?> = ObservableObject(nil)
    func getWeather(completion: @escaping(WeatherResult) -> Void){
        NetworkService.shared.getWeather(onSuccess: {result in
            completion(result)
        }, onError: {error in
        })
    }
    
    func getLocation(completion: @escaping(MyLocation) -> Void){
        LocationService.shared.getLocation(completion: {location in
            completion(location)
        })
    }
}
