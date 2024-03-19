//
//  BottomView.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import UIKit

class BottomView: UIView {

    let title: UILabel = {
        let title = UILabel()
        title.text = "Next 7 days"
        title.font = UIFont(name: "Inter-Bold", size: .init(w: 8))
        title.textColor = UIColor(hexString: "303345")
        title.textColor = .black
        return title
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let col = UICollectionView(frame: .zero, collectionViewLayout: layout)
        col.translatesAutoresizingMaskIntoConstraints = false
        col.register(DayCell.self, forCellWithReuseIdentifier: "day")
        col.delegate = self
        col.dataSource = self
        col.contentInset = UIEdgeInsets(top: .init(h: 0), left: .init(w: 15), bottom: .init(h: 0), right: .init(w: 15))
        col.backgroundColor = .clear
        return col
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .darkGray
        addSubview(title)
        addSubview(collectionView)
        
        title.anchorView(top: topAnchor, paddingTop: .init(h: 0))
        title.centerX(inView: self)
        
        collectionView.anchorView(top: title.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: .init(h: 5), paddingBottom: .init(h: 11))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension BottomView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "day", for: indexPath) as! DayCell
        cell.update()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.height-CGFloat(h: 15)
        return CGSize(width: height/2, height: height)
    }
}
    
    
