//
//  NewHomeViewController.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import UIKit

class NewHomeViewController: UIViewController {

    lazy var refreshController:  UIRefreshControl = {
        let controller = UIRefreshControl()
        controller.addTarget(self, action: #selector(pulledRefresh), for: .valueChanged)
        return controller
    }()
    
    let topView = TopView()
    let titleView = TitleView()
    let weatherMainView = WeatherMainTitleView()
    let descriptionView = DescriptionListView()
    let bottomView = BottomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        view.addSubview(refreshController)
        view.addSubview(topView)
        view.addSubview(titleView)
        view.addSubview(weatherMainView)
        view.addSubview(descriptionView)
        view.addSubview(bottomView)
        
        topView.delegate = self
        
//        refreshController.centerX(inView: view)
//        refreshController.centerY(inView: view)
        
        topView.anchorView(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: .init(h: 48))
        
        titleView.anchorView(top: topView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: .init(h: 81))
        
        weatherMainView.anchorView(top: titleView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: .init(h: 88))
        
        descriptionView.anchorView(top: weatherMainView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: .init(h: 154))
        
        bottomView.anchorView(top: descriptionView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: .init(h: 100))
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func pulledRefresh(){
        
    }

}

extension NewHomeViewController: HomeViewProtocols{
    func tappedOnSearch() {
        //go to the city choice
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "cityChoiseID") as! SearchViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
