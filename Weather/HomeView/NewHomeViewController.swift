//
//  NewHomeViewController.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import UIKit
import CoreLocation

class NewHomeViewController: UIViewController {
    
    lazy var refreshController:  UIRefreshControl = {
        let controller = UIRefreshControl()
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
        //        view.backgroundColor = .green
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        //        view.isUserInteractionEnabled = true
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
        //        view.layer.borderWidth = 0.5
        //        view.backgroundColor = .yellow
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
        //        view.widthAnchor.constraint(equalToConstant: .init(w: 414)).isActive = true
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
            //reload view
//            refreshController.endRefreshing()
            print("city changed")
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
        
        
//        getLocation()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        getLocation()
    }
    override func viewIsAppearing(_ animated: Bool) {
        refreshController.beginRefreshing()
    }
    
    @objc func pulledRefresh(){
        getLocation()
    }
    func getLocation() {
        
        
        
        switch locationManger.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManger = CLLocationManager()
            locationManger.delegate = self
            locationManger.desiredAccuracy = kCLLocationAccuracyBest
            locationManger.requestLocation()
            
        default:
            locationManger.delegate = self
            locationManger.requestWhenInUseAuthorization()
            locationManger.requestAlwaysAuthorization()
            print("error, no permission")
        }
        
        
        
    }
    
    func getWeather(){
        NetworkService.shared.getWeather(onSuccess: { [self] (result) in
            print(result.current)
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
    
    func updateCityInfo(){
        titleView.cityName.text = cityInformation.name
        titleView.dateLabel.text = Date.getTodaysDate()
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

extension NewHomeViewController: HomeViewProtocols{
    func selectedCity(name: String, lat: CLLocationDegrees, lon: CLLocationDegrees) {
        cityInformation = CityModel(name: name, lat: lat, lon: lon)
    }
    
    func tappedOnSearch() {
        //go to the city choice
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "cityChoiseID") as! SearchViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension NewHomeViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            
            let latitude: Double = location.coordinate.latitude
            let longitude: Double = location.coordinate.longitude
            
            
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
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways{
            manager.requestLocation()
        }
        else{
            showAlertMessage(title: "Permission need", message: "Go to settings page!!!", completion: {(done) in
                if done{
                    UIApplication.shared.open(URL(string: "App-prefs:LOCATION_SERVICES")!)
                }
            })
        }
        
    }
    
}
