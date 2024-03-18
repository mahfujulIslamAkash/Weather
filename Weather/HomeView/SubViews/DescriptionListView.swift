//
//  DescriptionListView.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import UIKit

class DescriptionListView: UIView {
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = .init(h: 12)
        return stack
    }()
    
    func getCellFor(name: String, value: String) -> UIView{
        lazy var view = UIView()
        let image = UIImageView()
        image.image = UIImage(named: name)
        view.addSubview(image)
        image.anchorView(left: view.leftAnchor, paddingLeft: .init(w: 11))
        image.centerY(inView: view)
        
        let title = UILabel()
        title.text = value
        view.addSubview(title)
        title.anchorView(right: view.rightAnchor, paddingRight: .init(w: 11))
        title.centerY(inView: view)
        view.layer.borderWidth = 0.5
        return view
    }
    
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
        return col
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cyan
        addSubview(collectionView)
        collectionView.anchorView(top: topAnchor, left: leftAnchor, bottom:  bottomAnchor, right: rightAnchor)
//        let a = getCellFor(name: "rain", value: "12cm")
//        stackView.addArrangedSubview(a)
//        stackView.addArrangedSubview(getCellFor(name: "wind", value: "12km/h"))
//        stackView.addArrangedSubview(getCellFor(name: "humidity", value: "65%"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension DescriptionListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DescriptionCell
        cell.update()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.width-30
        return CGSize(width: width, height: .init(h: 38))
    }
    
    
    
}
