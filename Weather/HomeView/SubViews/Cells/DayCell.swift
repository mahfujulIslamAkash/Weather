//
//  DayCell.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import UIKit

class DayCell: UICollectionViewCell {
    let time: UILabel = {
        let title = UILabel()
        title.text = "12:00"
        title.font = UIFont(name: "Inter-Regular", size: .init(w: 7))
        title.textColor = UIColor(hexString: "303345")
        title.textColor = .black
        return title
    }()
    
    let icon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "rain")
        return image
    }()
    
    let tmp: UILabel = {
        let title = UILabel()
        title.text = "12°"
        title.font = UIFont(name: "Inter-Regular", size: .init(w: 7))
        title.textColor = UIColor(hexString: "303345")
        title.textColor = .black
        return title
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    
    func update(daily: Daily){
        contentView.layer.borderWidth = 0.5
        contentView.layer.cornerRadius = 16
        
        contentView.addSubview(stackView)
//        stackView.anchorView(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
        stackView.centerX(inView: self)
        stackView.centerY(inView: self)
        
        stackView.addArrangedSubview(time)
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(tmp)
        
        let day = daily.dt
        let date = Date(timeIntervalSince1970: Double(day))
        let components = date.get(.day, .month, .year)
        guard let dayNumber = components.day else{
            return
        }
        let dayString = "\(dayNumber)"
        
//        let date = Date(timeIntervalSince1970: Double(daily.dt))
//        let hourString = Date.getHourFrom(date: date)
        time.text = dayString
        
        icon.image = UIImage(named: daily.weather[0].icon)
        tmp.text = "\(Int(daily.temp.day))°\(NetworkService.shared.defaultC ? "C" : "F")"
        
        
        
        
//        time.anchorView(left: contentView.leftAnchor, paddingLeft: .init(w: 11))
//        imageView.centerY(inView: contentView)
//        
//        cellName.anchorView(left: imageView.rightAnchor, paddingLeft: .init(w: 8))
//        cellName.centerY(inView: contentView)
//        
//        cellValue.anchorView(right: contentView.rightAnchor, paddingRight: .init(w: 11))
//        cellValue.centerY(inView: contentView)
    }
    
}
