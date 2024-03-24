//
//  HomeViewModel.swift
//  Weather
//
//  Created by Appnap Mahfuj on 24/3/24.
//

import Foundation

final class HomeViewModel{
    
    
    var weatherResult: ObservableObject<WeatherResult?> = ObservableObject(nil)
    var inBacground: ObservableObject<Bool?> = ObservableObject(nil)
    
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
    func goingBacgroungObserver(_ forID: NSNotification.Name?){
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(goingBackground), name: forID, object: nil)
    }
    func enterForegroundObserver(_ forID: NSNotification.Name?){
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(cameForeground), name: forID, object: nil)
    }
    @objc func cameForeground() {
        inBacground.value = false
        
    }
    @objc func goingBackground() {
        inBacground.value = true
        
    }
}
