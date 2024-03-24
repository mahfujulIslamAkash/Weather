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
            
    var weatherResult: WeatherResult!
    
    var cityInformation: CityModel!{
        didSet{
            NetworkService.shared.setLatitude(cityInformation.lat)
            NetworkService.shared.setLongitude(cityInformation.lon)
            getWeather()
        }
    }
    
    var homeVM: HomeViewModel = HomeViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.anchorView(top: view.topAnchor, left: view.leftAnchor,bottom: view.bottomAnchor, right: view.rightAnchor)
        scrollStackViewContainer.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        topView.delegate = self
        
        getLocation()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(cameForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        
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
        if Connectivity.isConnectedToInternet{
            getLocation()
        }
        else{
            showAlertForInternet()
        }
        
    }
    
    func getLocation() {
        homeVM.getLocation(completion: {[weak self] currentLocation in
            self?.cityInformation = CityModel(name: currentLocation.cityName, lat: currentLocation.lat, lon: currentLocation.lon)
        })
        
        
    }
    
    func getWeather(){
        if Connectivity.isConnectedToInternet{
            NetworkService.shared.getWeather(onSuccess: { [self] (result) in
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

