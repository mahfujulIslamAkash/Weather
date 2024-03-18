//
//  ViewController.swift
//  Weather
//
//  Created by Appnap Mahfuj on 18/3/24.
//

import UIKit

class HomeViewController: UIViewController {

    lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = Support.sheard.getBackground()
        return view
    }()
    
    let header: UIView = {
        let view = UIView()
        let searchButton = UIImageView()
        searchButton.image = Support.sheard.getSearchIcon()
        view.addSubview(searchButton)
        searchButton.anchorView(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: .init(w: 11), paddingBottom: .init(h: 0), width: .init(w: 25), height: .init(h: 25))
        
        let settingsButton = UIImageView()
        settingsButton.image = Support.sheard.getSettingsIcon()
        view.addSubview(settingsButton)
        settingsButton.anchorView(bottom: view.bottomAnchor, right: view.rightAnchor, paddingBottom: .init(h: 0), paddingRight: .init(w: 11), width: .init(w: 25), height: .init(h: 25))
        
//        view.layer.borderWidth = 0.5
        return view
    }()
    
    let cityName: UILabel = {
        let label = UILabel()
        label.text = "Stockholm,\nSweden"
        label.font = UIFont(name: "Inter-Medium", size: .init(w: 20))
        label.textColor = UIColor(hexString: "313341")
        label.textAlignment = .left
        label.numberOfLines = 0
        label.tag = 1
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Tue, Jun 30"
        label.font = UIFont(name: "Inter-Regular", size: .init(w: 9))
        label.textColor = UIColor(hexString: "9A938C")
        label.textAlignment = .left
        label.numberOfLines = 0
        label.tag = 2
        return label
    }()
    
    let topLabelStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = .init(h: 12)
        return stack
    }()
    
    lazy var mainWeatherStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.addArrangedSubview(mainWeatherImageView)
        stack.addArrangedSubview(mainWeatherRightStack)
        stack.layer.borderWidth = 0.5
        return stack
    }()
    
    lazy var mainWeatherRightStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
//        stack.spacing = 5
        stack.distribution = .fillEqually
//        stack.addArrangedSubview(mainWeatherImageView)
        let degreeLabel = UILabel()
        degreeLabel.text = "66.2°C"
        degreeLabel.font = UIFont(name: "Inter-Bold", size: .init(w: 25))
        degreeLabel.textColor = UIColor(hexString: "303345")
        degreeLabel.tag = 1
        degreeLabel.layer.borderWidth = 0.5
        stack.addArrangedSubview(degreeLabel)
        
        
        let currentWeather = UILabel()
        currentWeather.text = "Rainy"
        currentWeather.font = UIFont(name: "Inter-Regular", size: .init(w: 14))
        currentWeather.textColor = UIColor(hexString: "303345")
        currentWeather.tag = 2
        stack.addArrangedSubview(currentWeather)
        
        stack.layer.borderWidth = 0.5
        
        return stack
    }()
    
    let mainWeatherImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = Support.sheard.getMainWeatherDefaultImage()
        view.layer.borderWidth = 0.5
        return view
    }()
    
    let vm: WeatherViewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundImage)
        view.addSubview(header)
        view.addSubview(topLabelStack)
        view.addSubview(mainWeatherStack)
        
        backgroundImage.anchorView(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        header.anchorView(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: .init(h: 50))
        topLabelStack.anchorView(top: header.bottomAnchor, left: view.leftAnchor, paddingTop: .init(h: 10), paddingLeft: .init(w: 15))
        
        mainWeatherStack.anchorView(top: topLabelStack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: .init(h: 18), paddingLeft: .init(w: 15), paddingRight: .init(w: 15), height: .init(h: 88))
        
        topLabelStack.addArrangedSubview(cityName)
        topLabelStack.addArrangedSubview(dateLabel)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        guard let view = topLabelStack.viewWithTag(2) as? UILabel else{
//            return
//        }
//        view.text = "got it"
    }


}

