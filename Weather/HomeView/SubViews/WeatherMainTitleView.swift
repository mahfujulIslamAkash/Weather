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
        view.contentMode = .scaleToFill
        view.image = Support.sheard.getMainWeatherDefaultImage()
        view.layer.borderWidth = 0.5
        return view
    }()
    
    let temparatureLabel: UILabel = {
        let degreeLabel = UILabel()
        degreeLabel.text = "19°"
        degreeLabel.font = UIFont(name: "Inter-Bold", size: .init(w: 43))
        degreeLabel.textColor = UIColor(hexString: "303345")
        degreeLabel.tag = 1
        degreeLabel.layer.borderWidth = 0.5
        
        return degreeLabel
    }()
    
    let currentWeatherLabel: UILabel = {
        let currentWeather = UILabel()
        currentWeather.text = "Rainy"
        currentWeather.font = UIFont(name: "Inter-Regular", size: .init(w: 14))
        currentWeather.textColor = UIColor(hexString: "303345")
        currentWeather.tag = 2
        return currentWeather
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .brown
        addSubview(mainWeatherImageView)
        addSubview(temparatureLabel)
        addSubview(currentWeatherLabel)
        
        
        mainWeatherImageView.anchorView(left: leftAnchor, paddingLeft: .init(w: 30))
        mainWeatherImageView.centerY(inView: self)
        
        temparatureLabel.anchorView(top: topAnchor, left: mainWeatherImageView.rightAnchor, paddingTop: .init(h: 12), paddingLeft: .init(w: 10), height: .init(h: 52))
        currentWeatherLabel.anchorView(bottom: bottomAnchor, paddingBottom: .init(h: 12))
        currentWeatherLabel.centerX(inView: temparatureLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
