//
//  FullUI.swift
//  Weather
//
//  Created by Appnap Mahfuj on 25/3/24.
//

import UIKit
import CoreLocation

class FullUI: UIView {
    
    weak var delegate: HomeViewProtocols?

    //MARK: UI Elements
    lazy var refreshController:  UIRefreshControl = {
        let controller = UIRefreshControl()
        controller.tintColor = .black
        controller.addTarget(self, action: #selector(pulledRefresh), for: .valueChanged)
        return controller
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(refreshController)
        view.addSubview(scrollStackViewContainer)
        scrollStackViewContainer.anchorView(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        view.layer.borderWidth = 0.5
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    lazy var scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        //        view.distribution = .fill
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addArrangedSubview(topView)
        view.addArrangedSubview(titleView)
        view.addArrangedSubview(weatherMainView)
        view.addArrangedSubview(descriptionView)
        view.addArrangedSubview(bottomView)
        return view
    }()
    
    lazy var topView: TopView = {
        let view = TopView()
        view.heightAnchor.constraint(equalToConstant: .init(h: 25)).isActive = true
        view.delegate = self
        //        view.layer.borderWidth = 0.5
        return view
    }()
    let titleView: TitleView = {
        let view = TitleView()
        view.heightAnchor.constraint(equalToConstant: .init(h: 45)).isActive = true
        return view
    }()
    let weatherMainView: WeatherMainTitleView = {
        let view = WeatherMainTitleView()
        view.heightAnchor.constraint(equalToConstant: .init(h: 88)).isActive = true
        return view
    }()
    let descriptionView: DescriptionListView = {
        let view = DescriptionListView()
        view.heightAnchor.constraint(equalToConstant: .init(h: 154)).isActive = true
        return view
    }()
    let bottomView: BottomView = {
        let view = BottomView()
        view.heightAnchor.constraint(equalToConstant: .init(h: 100)).isActive = true
        return view
    }()
    
    init(width: CGFloat){
        super.init(frame: .zero)
        updateUI(width: width)
    }
    
    func updateUI(width: CGFloat){
        addSubview(scrollView)
        scrollView.anchorView(top: topAnchor, left: leftAnchor,bottom: bottomAnchor, right: rightAnchor)
        scrollStackViewContainer.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pulledRefresh(){
        
        delegate?.pulledRefresh()
    }
}


extension FullUI: HomeViewProtocols{
    func tappedOnSearch() {
        delegate?.tappedOnSearch()
    }
    
    func selectedCity(name: String, lat: CLLocationDegrees, lon: CLLocationDegrees) {
        delegate?.selectedCity(name: name, lat: lat, lon: lon)
    }
    
    
}
