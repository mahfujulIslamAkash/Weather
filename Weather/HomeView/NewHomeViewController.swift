//
//  NewHomeViewController.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import UIKit

class NewHomeViewController: UIViewController {

    let topView = TopView()
    let titleView = TitleView()
    let weatherMainView = WeatherMainTitleView()
    let descriptionView = DescriptionListView()
    let bottomView = BottomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(topView)
        view.addSubview(titleView)
        view.addSubview(weatherMainView)
        view.addSubview(descriptionView)
        view.addSubview(bottomView)
        
        topView.anchorView(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: .init(h: 48))
        
        titleView.anchorView(top: topView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: .init(h: 81))
        
        weatherMainView.anchorView(top: titleView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: .init(h: 88))
        
        descriptionView.anchorView(top: weatherMainView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: .init(h: 154))
        
        bottomView.anchorView(top: descriptionView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: .init(h: 100))
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
