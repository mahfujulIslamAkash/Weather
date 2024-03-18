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
        searchButton.anchorView(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: .init(w: 22), paddingBottom: .init(h: 0), width: .init(w: 40), height: .init(h: 40))
        
        let settingsButton = UIImageView()
        settingsButton.image = Support.sheard.getSettingsIcon()
        view.addSubview(settingsButton)
        settingsButton.anchorView(bottom: view.bottomAnchor, right: view.rightAnchor, paddingBottom: .init(h: 0), paddingRight: .init(w: 22), width: .init(w: 40), height: .init(h: 40))
        
//        view.layer.borderWidth = 0.5
        return view
    }()
    
    let cityName: UILabel = {
        let label = UILabel()
        label.text = "Stockholm,\nSweden"
        label.font = UIFont(name: "Inter-Medium", size: .init(w: 30))
        label.textColor = UIColor(hexString: "313341")
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Tue, Jun 30"
        label.font = UIFont(name: "Inter-Regular", size: .init(w: 9))
        label.textColor = UIColor(hexString: "9A938C")
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let topLabelStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = .init(h: 15)
        return stack
    }()
    
    let mainWeatherStack: UIStackView = {
        let stack = UIStackView()
//        stack.alignment = .leading
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
//        stack.spacing = .init(h: 15)
        return stack
    }()
    
    let mainWeatherImageView: UIImageView = {
        let view = UIImageView()
        view.image = Support.sheard.getMainWeatherDefaultImage()
        return view
    }()
    
    let vm: WeatherViewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundImage)
        view.addSubview(header)
        view.addSubview(topLabelStack)
        backgroundImage.anchorView(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        header.anchorView(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: .init(h: 100))
        topLabelStack.anchorView(top: header.bottomAnchor, left: view.leftAnchor, paddingTop: .init(h: 18), paddingLeft: .init(w: 25))
        topLabelStack.addArrangedSubview(cityName)
        topLabelStack.addArrangedSubview(dateLabel)
        // Do any additional setup after loading the view.
    }


}

