//
//  NewHomeViewController.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    lazy var fullUI: FullUI = {
        let view = FullUI(width: self.view.frame.width)
        view.delegate = self
        return view
    }()
    
    var homeVM: HomeViewModel = HomeViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinder()
        view.addSubview(fullUI)
        fullUI.anchorView(top: view.topAnchor, left: view.leftAnchor,bottom: view.bottomAnchor, right: view.rightAnchor)
        
        getWeather()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(cameForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        
    }
    
    
    override func viewIsAppearing(_ animated: Bool) {
//        if Connectivity.isConnectedToInternet{
//            if !homeVM.havingCurrentLocation(){
//                fullUI.refreshController.beginRefreshing()
//
//            }
//        }
//        else{
//            showAlertForInternet()
//        }
        getWeather()
        
    }
    
    @objc func pulledRefresh(){
        getWeather()
        
    }
    
    func getWeather(){
        if Connectivity.isConnectedToInternet{
            fullUI.refreshController.beginRefreshing()
            homeVM.getLocation()
        }else{
            fullUI.refreshController.endRefreshing()
            showAlertForInternet()
            
        }
        
    }
    
    func setupBinder(){
        homeVM.weatherResult.binds({[weak self] result in
            if let _ = result{
                self?.fullUI.refreshController.endRefreshing()
                self?.updateUI()
            }else{
                
            }
            
        })
    }
    func updateUI(){
        updateCityInfo()
        updateMainViewInfo()
        updateDescriptionViewInfo()
        updateBottomViewInfo()
    }
}


//MARK: UI Update functionality
extension HomeViewController{
    func updateCityInfo(){
        if !homeVM.havingCurrentLocation(){
            getWeather()
        }
        else{
            fullUI.titleView.cityName.text = homeVM.getCityName()
            fullUI.titleView.dateLabel.text = Date.getTodaysDate()
        }
        
    }
    func updateMainViewInfo(){
        if let currentWeather = homeVM.weatherResult.value?.current{
            fullUI.weatherMainView.mainWeatherImageView.image = UIImage(named: currentWeather.weather[0].icon)
            fullUI.weatherMainView.temparatureLabel.text = "\(Int(currentWeather.temp))°"
            fullUI.weatherMainView.currentWeatherLabel.text = currentWeather.weather[0].description.capitalized
        }
        
    }
    func updateDescriptionViewInfo(){
        if let currentWeather = homeVM.weatherResult.value?.current{
            fullUI.descriptionView.updateData(weatherData: currentWeather)
        }
        
    }
    func updateBottomViewInfo(){
        if let daily = homeVM.weatherResult.value?.daily{
            fullUI.bottomView.updateData(daily: daily)
        }
        
    }
    @objc func cameForeground() {
        print("cameForeground")
        if !Connectivity.isConnectedToInternet{
            showAlertForInternet()
        }
        
    }
}

//MARK: HomeView's Delegate
extension HomeViewController: HomeViewProtocols{
    func selectedCity(name: String, lat: CLLocationDegrees, lon: CLLocationDegrees) {
        homeVM.setLocationData(location: MyLocation(cityName: name, lat: lat, lon: lon))
        
    }
    
    func tappedOnSearch() {
        //go to the city choice
        if Connectivity.isConnectedToInternet{
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "cityChoiseID") as! SearchViewController
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            showAlertForInternet()
        }
        
    }
    
    
}

