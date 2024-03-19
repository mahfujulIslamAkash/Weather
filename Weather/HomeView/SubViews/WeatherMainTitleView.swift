//
//  WeatherMainTitleView.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import UIKit

class WeatherMainTitleView: UIView {
    
    let mainWeatherImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = Support.sheard.getMainWeatherDefaultImage()
//        view.layer.borderWidth = 0.5
        return view
    }()
    
    let temparatureLabel: UILabel = {
        let degreeLabel = UILabel()
        degreeLabel.text = "19°"
        degreeLabel.font = UIFont(name: "Inter-Bold", size: .init(w: 43))
        degreeLabel.textColor = UIColor(hexString: "303345")
        degreeLabel.tag = 1
//        degreeLabel.layer.borderWidth = 0.5
        
        return degreeLabel
    }()
    
    let currentWeatherLabel: UILabel = {
        let currentWeather = UILabel()
        currentWeather.text = "Rainy"
        currentWeather.font = UIFont(name: "Inter-Regular", size: .init(w: 10))
        currentWeather.textColor = UIColor(hexString: "303345")
        currentWeather.textAlignment = .center
        currentWeather.numberOfLines = 0
//        currentWeather.layer.borderWidth = 0.5
        return currentWeather
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.addArrangedSubview(temparatureLabel)
        stack.addArrangedSubview(currentWeatherLabel)
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .brown
        addSubview(mainWeatherImageView)
//        addSubview(temparatureLabel)
//        addSubview(currentWeatherLabel)
        addSubview(stack)
        
        
        mainWeatherImageView.anchorView(top: topAnchor, left: leftAnchor,bottom: bottomAnchor, paddingLeft: .init(w: 15), width: .init(w: 83), height: .init(h: 80))
        
        stack.anchorView(left: mainWeatherImageView.rightAnchor, paddingLeft: .init(w: 10), height: .init(h: 62))
        stack.centerY(inView: self)
        
//        temparatureLabel.anchorView(top: topAnchor, left: mainWeatherImageView.rightAnchor, paddingTop: .init(h: 12), paddingLeft: .init(w: 10), height: .init(h: 52))
//        
//        currentWeatherLabel.anchorView(top: temparatureLabel.bottomAnchor, width: 150)
//        currentWeatherLabel.centerX(inView: temparatureLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
