//
//  HomeViewModel.swift
//  Weather
//
//  Created by Appnap Mahfuj on 24/3/24.
//

import Foundation

final class HomeViewModel{
    
    weak var delegate: HomeViewProtocols?
    var weatherResult: ObservableObject<WeatherResult?> = ObservableObject(nil)
//    var inBacground: ObservableObject<Bool?> = ObservableObject(nil)
    
    func getLocation(){
        
        if Connectivity.isConnectedToInternet{
            delegate?.startLoading()
            fetchLocation()
        }else{
            delegate?.noInternet()
            
        }
        
    }
    
    func fetchLocation(){
        LocationService.shared.getLocation(completion: {[weak self] location in
            NetworkService.shared.setLocationData(location: location)
            self?.getWeather()
        })
    }
    
    
    private func getWeather(){
        NetworkService.shared.getWeather(onSuccess: {[weak self] result in
            self?.weatherResult.value = result
            self?.delegate?.endLoading()
        }, onError: {[weak self] error in
            self?.delegate?.endLoading()
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
        delegate?.cameForeground()
        
    }
    @objc func goingBackground() {
        delegate?.goingBackground()
        
    }
    
    func goToSerchVC(completion: @escaping(Bool) ->Void){
        if Connectivity.isConnectedToInternet{
            completion(true)
        }else{
            completion(false)
        }
    }
}
