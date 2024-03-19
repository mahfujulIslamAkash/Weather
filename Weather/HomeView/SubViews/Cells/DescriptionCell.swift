//
//  DescriptionCell.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import UIKit

class DescriptionCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "rain")
        image.contentMode = .scaleAspectFill
//        image.layer.borderWidth = 0.5
        return image
    }()
    
    let cellName: UILabel = {
        let title = UILabel()
        title.text = "Rain"
        title.font = UIFont(name: "Inter-Regular", size: .init(w: 7))
        title.textColor = UIColor(hexString: "303345")
        title.textColor = .black
        return title
    }()
    
    let cellValue: UILabel = {
        let title = UILabel()
        title.text = "22cm"
        title.font = UIFont(name: "Inter-Regular", size: .init(w: 7))
        title.textColor = UIColor(hexString: "303345")
        title.textColor = .black
        return title
    }()
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.cornerRadius = 20
        blurEffectView.clipsToBounds = true
        return blurEffectView
    }()
    
    func update(imageIcon: String, title: String, value: String){
        contentView.backgroundColor = .clear
//        contentView.layer.borderWidth = 0.5
        contentView.layer.cornerRadius = 15
        contentView.addSubview(blurEffectView)
        contentView.addSubview(imageView)
        contentView.addSubview(cellName)
        contentView.addSubview(cellValue)
        
        
        
        
        
        blurEffectView.anchorView(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
        
        cellName.anchorView(left: contentView.leftAnchor, paddingLeft: .init(w: 15))
        cellName.centerY(inView: contentView)
        
        cellValue.anchorView(right: contentView.rightAnchor, paddingRight: .init(w: 11))
        cellValue.centerY(inView: contentView)
        
//        imageView.image = UIImage(named: imageIcon)
        cellName.text = title
        cellValue.text = value
    }
    
    
    
}
