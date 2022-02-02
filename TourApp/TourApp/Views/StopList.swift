//
//  StopList.swift
//  IUCA Tour
//
//  Created by User on 1/16/22.
//

import UIKit

private let reuseIdentifier = "StopListCell"


class StopList: UIView {
    //MARK: - Properties
    var orr = ["1. Прихожая", "2. Прихожая", "3. Прихожая", "4. Прихожая", "4. Прихожая", "4. Прихожая", "4. Прихожая", "4. Прихожая", "4. Прихожая", "4. Прихожая", "4. Прихожая"]
    
    lazy var collectionViewForStopList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        layout.scrollDirection = .vertical
        cv.isPagingEnabled = true
//        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        
        cv.bounces = false
        cv.alwaysBounceVertical = false
        
        return cv
    }()
    
   
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    
    
    func configureUI() {
        collectionViewForStopList.register(StopListCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        addSubview(collectionViewForStopList)
        collectionViewForStopList.addConstraintsToFillView(self)
        
       
        
    }
}


extension StopList: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as!  StopListCell
        cell.text = orr[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orr.count
    }
    
    
}

extension StopList: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 26)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        14
    }
}

extension StopList: UICollectionViewDelegate {
    
}
