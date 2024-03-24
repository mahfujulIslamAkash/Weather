//
//  LocationService.swift
//  Weather
//
//  Created by Appnap Mahfuj on 24/3/24.
//

import Foundation
import CoreLocation
import UIKit

struct MyLocation{
    var cityName: String
    var lat: Double
    var lon: Double
}

final class LocationService: NSObject{
    static var shared = LocationService()
    private var currentLocation: MyLocation?
    
    var locationHandler: ((MyLocation)->Void)?
    private let locationManager: CLLocationManager!
    
    override init() {
        self.locationManager = CLLocationManager()
    }
    
    private func isPermitted() -> Bool{
        if (locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways){
            return true
        }
        else{
            return false
        }
    }
    
    private func availableForAskingPermission() -> Bool{
        if (locationManager.authorizationStatus == .denied || locationManager.authorizationStatus == .restricted){
            return false
        }
        else{
            return true
        }
    }
    
    func getLocation(completion: @escaping(MyLocation) -> Void){
        locationHandler = completion
        if isPermitted(){
            //get location
            locationManager.delegate = self
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
            
        }
        else{
            if availableForAskingPermission(){
                //ask for permission
                locationManager.requestWhenInUseAuthorization()
                locationManager.delegate = self
            }else{
                //show alert for settings
//                UIViewController().showAlertForPermission()
            }
        }
    }
}

extension LocationService : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            
            let latitude: Double = location.coordinate.latitude
            let longitude: Double = location.coordinate.longitude
            
            manager.stopUpdatingLocation()
            
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { [self] (placemarks, error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                }
                if let placemarks = placemarks {
                    if placemarks.count > 0 {
                        let placemark = placemarks[0]
                        if let city = placemark.locality {
                            let location =  MyLocation(cityName: city, lat: latitude, lon: longitude)
                            if let handler = locationHandler{
                                handler(location)
                            }
                        }
                        else{
                            if let cityName = placemark.name {
                                let location =  MyLocation(cityName: cityName, lat: latitude, lon: longitude)
                                if let handler = locationHandler{
                                    handler(location)
                                }
                            }
                            
                        }
                    }
                }
            }
            
            
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error.localizedDescription)
        manager.stopUpdatingLocation()
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways{
            if let handler = locationHandler{
                getLocation(completion: handler)
            }
            else{
                debugPrint("error")
            }
            
        }
        else{
//            UIViewController().showAlertForPermission()
        }
        
    }
    
}
