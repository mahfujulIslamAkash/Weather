//
//  TopView.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import UIKit

class TopView: UIView {
    
    weak var delegate: HomeViewProtocols?
    
    lazy var header: UIView = {
        let view = UIView()
        let searchButton = UIImageView()
        searchButton.image = Support.sheard.getSearchIcon()
        view.addSubview(searchButton)
        searchButton.anchorView(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: .init(w: 11), paddingBottom: .init(h: 0), width: .init(w: 25), height: .init(h: 25))
//        searchButton.target(forAction: #selector(searchTapped), withSender: nil)
        searchButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchTapped)))
        searchButton.layer.borderWidth = 0.5
        searchButton.isUserInteractionEnabled = true
        
        let settingsButton = UIImageView()
        settingsButton.image = Support.sheard.getSettingsIcon()
        view.addSubview(settingsButton)
        settingsButton.anchorView(bottom: view.bottomAnchor, right: view.rightAnchor, paddingBottom: .init(h: 0), paddingRight: .init(w: 11), width: .init(w: 25), height: .init(h: 25))
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .red
        addSubview(header)
        header.anchorView(top: topAnchor, left: leftAnchor, bottom:  bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func searchTapped(){
        delegate?.tappedOnSearch()
    }
    
}
