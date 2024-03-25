//
//  DayCell.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import UIKit

class WeeklyForecastCell: UICollectionViewCell {
    let dayOfMonth: UILabel = {
        let title = UILabel()
        title.text = "12:00"
        title.font = UIFont(name: "Inter-Bold", size: .init(w: 7))
        title.textColor = .white
        title.layer.shadowRadius = 50
        title.textAlignment = .center
        return title
    }()
    
    let weatherIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "rain")
        image.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        return image
    }()
    
    let averageTemperature: UILabel = {
        let title = UILabel()
        title.text = "12°"
        title.font = UIFont(name: "Inter-Bold", size: .init(w: 7))
        title.textColor = .white
        title.layer.shadowRadius = 50
        title.textAlignment = .center
        return title
    }()
    
    let verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.cornerRadius = .init(w: 10)
        blurEffectView.clipsToBounds = true
        return blurEffectView
    }()
    
    func update(daily: Daily){

        contentView.backgroundColor = .clear
        contentView.addSubview(blurEffectView)
        contentView.addSubview(verticalStackView)
        
        verticalStackView.centerX(inView: self)
        verticalStackView.centerY(inView: self)
        
        verticalStackView.addArrangedSubview(dayOfMonth)
        verticalStackView.addArrangedSubview(weatherIcon)
        verticalStackView.addArrangedSubview(averageTemperature)
        
        blurEffectView.anchorView(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: .init(h: 0), paddingBottom: .init(h: 0))
        
        
        
        dayOfMonth.text = Date.dayOfMonthFromDt(dt: daily.dt)
        
        weatherIcon.image = UIImage(named: daily.weather[0].icon)
        averageTemperature.text = "\(Int(daily.temp.day))°\(NetworkService.shared.defaultC ? "C" : "F")"
        
    }
    
}
