//
//  TopView.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import UIKit

class TopView: UIView {
    
    weak var delegate: HomeViewProtocols?
    
    var searchTappedCallback: (()->Void)?
    lazy var header: UIView = {
        let view = UIView()
        let searchButton = UIImageView()
        searchButton.image = Assets.shared.getSearchIcon()
        searchButton.contentMode = .scaleAspectFit
        view.addSubview(searchButton)
        searchButton.anchorView(top: view.topAnchor, left: view.leftAnchor, paddingLeft: .init(w: 11), width: .init(w: 25), height: .init(h: 25))
        searchButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchTapped)))
        searchButton.isUserInteractionEnabled = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        updateUI()
    }
    init(searchCallBack: @escaping()->Void){
        super.init(frame: .zero)
        updateUI()
        self.searchTappedCallback = searchCallBack
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func updateUI(){
        addSubview(header)
        header.anchorView(top: topAnchor, left: leftAnchor, bottom:  bottomAnchor, right: rightAnchor)
    }
    @objc func searchTapped(){
//        delegate?.tappedOnSearch()
        searchTappedCallback!()
    }
    
}
