//
//  DescriptionListView.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import UIKit

class DescriptionListView: UIView {
    var forecasts = Assets.shared.forecasts
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let col = UICollectionView(frame: .zero, collectionViewLayout: layout)
        col.translatesAutoresizingMaskIntoConstraints = false
        col.register(TodayForecastCell.self, forCellWithReuseIdentifier: "cell")
        col.delegate = self
        col.dataSource = self
        col.contentInset = UIEdgeInsets(top: .init(h: 15), left: .init(w: 15), bottom: .init(h: 15), right: .init(w: 15))
        col.backgroundColor = .clear
        col.isUserInteractionEnabled = false
        return col
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        collectionView.anchorView(top: topAnchor, left: leftAnchor, bottom:  bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateData(weatherData: Current){
        forecasts[0].description = "\(weatherData.dew_point)cm"
        forecasts[1].description = "\(weatherData.humidity)%"
        forecasts[2].description = "\(weatherData.wind_speed)km/h"
        collectionView.reloadData()
    }

}

extension DescriptionListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TodayForecastCell
        cell.update(forecasts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.width-30
        return CGSize(width: width, height: .init(h: 38))
    }
    
    
    
}
