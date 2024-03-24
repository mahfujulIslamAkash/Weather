//
//  TitleView.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import UIKit

class TitleView: UIView {
    
    let cityName: UILabel = {
        let label = UILabel()
        label.text = "Stockholm Sweden"
        label.font = UIFont(name: "Inter-Medium", size: .init(w: 20))
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
        stack.distribution = .fillProportionally
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(topLabelStack)
        topLabelStack.addArrangedSubview(cityName)
        topLabelStack.addArrangedSubview(dateLabel)
        topLabelStack.anchorView(top: topAnchor, left: leftAnchor, bottom:  bottomAnchor, right: rightAnchor, paddingLeft: .init(w: 15))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
