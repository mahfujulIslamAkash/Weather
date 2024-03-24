//
//  NetworkService.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    var defaultC: Bool = true
    
    let URL_SAMPLE = "https://api.openweathermap.org/data/2.5/onecall?lat=60.99&lon=30.9&appid=89575d3c850c4fe09a01e9aedf6aec9e"
    let URL_API_KEY = "89575d3c850c4fe09a01e9aedf6aec9e"
    var URL_GET_ONE_CALL = ""
    let URL_BASE = "https://api.openweathermap.org/data/2.5"
//    var URL_LATITUDE = "60.99"
//    var URL_LONGITUDE = "30.0"
//    var CITY_NAME = "San Francisco"
    var CURRENT_LOCATION: MyLocation?
    
    let session = URLSession(configuration: .default)
    
    func buildURL() -> String? {
        if let location = CURRENT_LOCATION{
            URL_GET_ONE_CALL = "/onecall?lat=" + "\(location.lat)" + "&lon=" + "\(location.lon)" + (defaultC ? "&units=metric" : "&units=imperial") + "&appid=" + URL_API_KEY
            return URL_BASE + URL_GET_ONE_CALL
        }else{
            return nil
        }
        
    }
    
    func setLocationData(location: MyLocation){
        CURRENT_LOCATION = location
    }
    
    func havingCurrentLocation() -> Bool{
        if let _ = CURRENT_LOCATION{
            return true
        }else{
            return false
        }
    }
    
//    func setLatitude(_ latitude: String) {
//        URL_LATITUDE = latitude
//    }
//    
//    func setLatitude(_ latitude: Double) {
//        setLatitude(String(latitude))
//    }
//    
//    func setLongitude(_ longitude: String) {
//        URL_LONGITUDE = longitude
//    }
//    
//    func setLongitude(_ longitude: Double) {
//        setLongitude(String(longitude))
//    }
//    func setCityName(_ name: String){
//        CITY_NAME = name
//    }
    
    func getWeather(onSuccess: @escaping (WeatherResult) -> Void, onError: @escaping (String) -> Void) {
        guard let path = buildURL() else {
            onError("Error building URL")
            return
        }
        guard let url = URL(string: path) else {
            onError("Error building URL")
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let items = try JSONDecoder().decode(WeatherResult.self, from: data)
                        onSuccess(items)
                    } else {
                        onError("Response wasn't 200. It was: " + "\n\(response.statusCode)")
                    }
                } catch {
                    onError(error.localizedDescription)
                }
            }
            
        }
        task.resume()
    }
    
}
