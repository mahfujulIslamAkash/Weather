//
//  DescriptionListView.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import UIKit

class DescriptionListView: UIView {
    var dummyData = ["23cm", "56%", "23km/H"]
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let col = UICollectionView(frame: .zero, collectionViewLayout: layout)
        col.translatesAutoresizingMaskIntoConstraints = false
        col.register(DescriptionCell.self, forCellWithReuseIdentifier: "cell")
        col.delegate = self
        col.dataSource = self
        col.contentInset = UIEdgeInsets(top: .init(h: 15), left: .init(w: 15), bottom: .init(h: 15), right: .init(w: 15))
        col.backgroundColor = .clear
        col.isUserInteractionEnabled = false
//        col.layer.borderWidth = 0.5
        return col
    }()
    
    var weatherData: WeatherResult!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .cyan
        addSubview(collectionView)
        collectionView.anchorView(top: topAnchor, left: leftAnchor, bottom:  bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateData(weatherData: WeatherResult){
        self.weatherData = weatherData
        dummyData = [
            "\(weatherData.current.dew_point)cm",
            "\(weatherData.current.humidity)%",
            "\(weatherData.current.wind_speed)km/h"
        ]
        collectionView.reloadData()
    }

}

extension DescriptionListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DescriptionCell
        if indexPath.row == 0{
            cell.update(imageIcon: "rain", title: "Rain", value: dummyData[0])
        }
        else if indexPath.row == 1{
            cell.update(imageIcon: "humidity", title: "Humidity", value: dummyData[1])
        }
        else{
            cell.update(imageIcon: "wind", title: "Wind", value: dummyData[2])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.width-30
        return CGSize(width: width, height: .init(h: 38))
    }
    
    
    
}
