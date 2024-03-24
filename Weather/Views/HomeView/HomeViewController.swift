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
    
    var homeVM: HomeViewModel = HomeViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        binds()
        view.addSubview(scrollView)
        scrollView.anchorView(top: view.topAnchor, left: view.leftAnchor,bottom: view.bottomAnchor, right: view.rightAnchor)
        scrollStackViewContainer.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        topView.delegate = self
        
        getWeather()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(cameForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        
    }
    
    
    override func viewIsAppearing(_ animated: Bool) {
        if Connectivity.isConnectedToInternet{
            if !homeVM.havingCurrentLocation(){
                refreshController.beginRefreshing()
                getWeather()
            }
        }
        else{
            showAlertForInternet()
        }
        
    }
    
    @objc func pulledRefresh(){
        if Connectivity.isConnectedToInternet{
            getWeather()
        }
        else{
            showAlertForInternet()
        }
        
    }
    
    func getWeather(){
        homeVM.getLocation()
    }
    
    func binds(){
        homeVM.weatherResult.binds({[weak self] result in
            if let _ = result{
                self?.refreshController.endRefreshing()
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
    
//    func getWeather(){
//        homeVM.getWeather()
//        if Connectivity.isConnectedToInternet{
//            NetworkService.shared.getWeather(onSuccess: { [self] (result) in
//                weatherResult = result
//                DispatchQueue.main.async { [self] in
//                    UIView.transition(with: self.view, duration: 0.25, options: .transitionCrossDissolve, animations: { [self] in
//                        updateCityInfo()
//                        updateMainViewInfo()
//                        updateDescriptionViewInfo()
//                        updateBottomViewInfo()
//                    }, completion: { [self]_ in
//                        refreshController.endRefreshing()
//                    })
//                    
//                }
//                
//                
//            }) { [self] (errorMessage) in
//                debugPrint(errorMessage)
//                refreshController.endRefreshing()
//            }
//        }
//        else{
//            showAlertForInternet()
//        }
//        
//    }
}


//MARK: UI Update functionality
extension HomeViewController{
    func updateCityInfo(){
        if !homeVM.havingCurrentLocation(){
            getWeather()
        }
        else{
            titleView.cityName.text = homeVM.getCityName()
            titleView.dateLabel.text = Date.getTodaysDate()
        }
        
    }
    func updateMainViewInfo(){
        if let currentWeather = homeVM.weatherResult.value?.current{
            weatherMainView.mainWeatherImageView.image = UIImage(named: currentWeather.weather[0].icon)
            weatherMainView.temparatureLabel.text = "\(Int(currentWeather.temp))°"
            weatherMainView.currentWeatherLabel.text = currentWeather.weather[0].description.capitalized
        }
        
    }
    func updateDescriptionViewInfo(){
        if let currentWeather = homeVM.weatherResult.value?.current{
            descriptionView.updateData(weatherData: currentWeather)
        }
        
    }
    func updateBottomViewInfo(){
        if let daily = homeVM.weatherResult.value?.daily{
            bottomView.updateData(daily: daily)
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

