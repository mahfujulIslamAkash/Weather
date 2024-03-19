//
//  NewHomeViewController.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    //MARK: UI Elements
    lazy var refreshController:  UIRefreshControl = {
        let controller = UIRefreshControl()
        controller.tintColor = .black
        controller.addTarget(self, action: #selector(pulledRefresh), for: .valueChanged)
        return controller
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(refreshController)
        view.addSubview(scrollStackViewContainer)
        scrollStackViewContainer.anchorView(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        view.layer.borderWidth = 0.5
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    lazy var scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        //        view.distribution = .fill
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addArrangedSubview(topView)
        view.addArrangedSubview(titleView)
        view.addArrangedSubview(weatherMainView)
        view.addArrangedSubview(descriptionView)
        view.addArrangedSubview(bottomView)
        return view
    }()
    
    let topView: TopView = {
        let view = TopView()
        view.heightAnchor.constraint(equalToConstant: .init(h: 25)).isActive = true
        //        view.layer.borderWidth = 0.5
        return view
    }()
    let titleView: TitleView = {
        let view = TitleView()
        view.heightAnchor.constraint(equalToConstant: .init(h: 45)).isActive = true
        return view
    }()
    let weatherMainView: WeatherMainTitleView = {
        let view = WeatherMainTitleView()
        view.heightAnchor.constraint(equalToConstant: .init(h: 88)).isActive = true
        return view
    }()
    let descriptionView: DescriptionListView = {
        let view = DescriptionListView()
        view.heightAnchor.constraint(equalToConstant: .init(h: 154)).isActive = true
        return view
    }()
    let bottomView: BottomView = {
        let view = BottomView()
        view.heightAnchor.constraint(equalToConstant: .init(h: 100)).isActive = true
        return view
    }()
    
    var locationManger: CLLocationManager = CLLocationManager()
    
    var weatherResult: WeatherResult!
    
    var cityInformation: CityModel!{
        didSet{
//            print("city changed")
            NetworkService.shared.setLatitude(cityInformation.lat)
            NetworkService.shared.setLongitude(cityInformation.lon)
            getWeather()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.anchorView(top: view.topAnchor, left: view.leftAnchor,bottom: view.bottomAnchor, right: view.rightAnchor)
        scrollStackViewContainer.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        topView.delegate = self
        
        getLocation()
        
        
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        if Connectivity.isConnectedToInternet{
            if cityInformation == nil{
                refreshController.beginRefreshing()
                getLocation()
            }
        }
        else{
            showAlertForInternet()
        }
        
    }
    
    @objc func pulledRefresh(){
        getLocation()
    }
    
    func getLocation() {
        switch locationManger.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManger = CLLocationManager()
            locationManger.delegate = self
            locationManger.startUpdatingLocation()

        case .denied, .restricted:
            showAlertForPermission()
        default:
            locationManger.delegate = self
//            locationManger.startUpdatingLocation()
            locationManger.requestWhenInUseAuthorization()
            locationManger.requestAlwaysAuthorization()
            print("error, no permission")
        }
        
        
        
    }
    
    func getWeather(){
        if Connectivity.isConnectedToInternet{
            NetworkService.shared.getWeather(onSuccess: { [self] (result) in
//                print(result.current)
                weatherResult = result
                DispatchQueue.main.async { [self] in
                    UIView.transition(with: self.view, duration: 0.25, options: .transitionCrossDissolve, animations: { [self] in
                        updateCityInfo()
                        updateMainViewInfo()
                        updateDescriptionViewInfo()
                        updateBottomViewInfo()
                    }, completion: { [self]_ in
                        refreshController.endRefreshing()
                    })
                    
                }
                
                
            }) { [self] (errorMessage) in
                debugPrint(errorMessage)
                refreshController.endRefreshing()
            }
        }
        else{
            showAlertForInternet()
        }
        
    }
}


//MARK: UI Update functionality
extension HomeViewController{
    func updateCityInfo(){
        if cityInformation == nil{
            getLocation()
        }
        else{
            titleView.cityName.text = cityInformation.name
            titleView.dateLabel.text = Date.getTodaysDate()
        }
        
    }
    func updateMainViewInfo(){
        weatherMainView.mainWeatherImageView.image = UIImage(named: weatherResult.current.weather[0].icon)
        weatherMainView.temparatureLabel.text = "\(Int(weatherResult.current.temp))°"
        weatherMainView.currentWeatherLabel.text = weatherResult.current.weather[0].description.capitalized
    }
    func updateDescriptionViewInfo(){
        descriptionView.updateData(weatherData: weatherResult)
    }
    func updateBottomViewInfo(){
        bottomView.updateData(weatherData: weatherResult)
    }
}

//MARK: HomeView's Delegate
extension HomeViewController: HomeViewProtocols{
    func selectedCity(name: String, lat: CLLocationDegrees, lon: CLLocationDegrees) {
        cityInformation = CityModel(name: name, lat: lat, lon: lon)
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
//MARK: Location Delegate
extension HomeViewController: CLLocationManagerDelegate{
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
                            cityInformation = CityModel(name: city, lat: latitude, lon: longitude)
                        }
                        else{
                            if let cityName = placemark.name {
                                cityInformation = CityModel(name: cityName, lat: latitude, lon: longitude)
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
            manager.startUpdatingLocation()
        }
        else{
            showAlertForPermission()
        }
        
    }
    
}
