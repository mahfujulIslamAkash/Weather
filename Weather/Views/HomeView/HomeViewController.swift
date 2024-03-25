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
        let view = FullUI(width: self.view.frame.width, pull: {[weak self] in
            print("home pull")
            self?.pulledRefresh()
        }, searchCallback: {[weak self] in
            self?.tappedOnSearch()
            
        })
        return view
    }()
    
    var homeVM: HomeViewModel = HomeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinder()
        view.addSubview(fullUI)
        fullUI.anchorView(top: view.topAnchor, left: view.leftAnchor,bottom: view.bottomAnchor, right: view.rightAnchor)
        
        getLocation()
        
        homeVM.enterForegroundObserver(UIApplication.willEnterForegroundNotification)
        homeVM.goingBacgroungObserver(UIApplication.didEnterBackgroundNotification)
        homeVM.delegate = self
        
    }
    
    
    override func viewIsAppearing(_ animated: Bool) {
        fullUI.refreshController.beginRefreshing()
        
    }
    
    @objc func pulledRefresh(){
        getLocation()
    }
    
    func tappedOnSearch() {
        homeVM.goToSerchVC(completion: {[weak self] success in
            if success{
                self?.goToSearchVC()
            }else{
                self?.showAlertForInternet()
            }
        })
        
    }
    
    func getLocation(){
        homeVM.getLocation()
    }
    func goToSearchVC(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "cityChoiseID") as! SearchViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupBinder(){
        homeVM.weatherResult.binds({[weak self] result in
            if let _ = result{
                self?.fullUI.refreshController.endRefreshing()
                self?.updateUI()
            }
        })
    }
}


//MARK: UI Update functionality
extension HomeViewController{
    func updateUI(){
        updateCityInfo()
        updateMainViewInfo()
        updateDescriptionViewInfo()
        updateBottomViewInfo()
    }
    
    func updateCityInfo(){
        if !homeVM.havingCurrentLocation(){
            getLocation()
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
}

//MARK: HomeView's Delegate
extension HomeViewController: HomeViewProtocols{
    func noInternet() {
        showAlertForInternet()
    }
    func endLoading() {
        DispatchQueue.main.async {
            self.fullUI.refreshController.endRefreshing()
        }
    }
    
    func cameForeground() {
        if !Connectivity.isConnectedToInternet{
            showAlertForInternet()
        }
    }
    
    func selectedCity(name: String, lat: CLLocationDegrees, lon: CLLocationDegrees) {
        homeVM.setLocationData(location: MyLocation(cityName: name, lat: lat, lon: lon))
        
    }
}

