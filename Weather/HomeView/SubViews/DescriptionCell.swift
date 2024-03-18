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
        return image
    }()
    
    let cellName: UILabel = {
        let title = UILabel()
        title.text = "Rain"
        title.textColor = .black
        return title
    }()
    
    let cellValue: UILabel = {
        let title = UILabel()
        title.text = "22cm"
        title.textColor = .black
        return title
    }()
    
    func update(){
        contentView.layer.borderWidth = 0.5
        contentView.addSubview(imageView)
        contentView.addSubview(cellName)
        contentView.addSubview(cellValue)
        
        imageView.anchorView(left: contentView.leftAnchor, paddingLeft: .init(w: 11))
        imageView.centerY(inView: contentView)
        
        cellName.anchorView(left: imageView.rightAnchor, paddingLeft: .init(w: 8))
        cellName.centerY(inView: contentView)
        
        cellValue.anchorView(right: contentView.rightAnchor, paddingRight: .init(w: 11))
        cellValue.centerY(inView: contentView)
    }
    
    
    
}
