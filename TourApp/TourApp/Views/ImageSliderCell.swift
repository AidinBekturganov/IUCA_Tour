//
//  ImageSliderCell.swift
//  IUCA Tour
//
//  Created by User on 1/16/22.
//

import UIKit

class ImageSliderCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill

//        iv.image = #imageLiteral(resourceName: "SD")
        
        return iv
    }()
    
    var currentImage: UIImage! {
        didSet {
            imageView.image = currentImage
        }
    }
    
    var amountOfImages: Int! {
        didSet {
            pageControl.isUserInteractionEnabled = false
            pageControl.numberOfPages = amountOfImages
        }
    }
    
    var currentPage: Int! {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        
        return pc
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
        
        addSubview(imageView)
        imageView.addConstraintsToFillView(self)
        
        addSubview(pageControl)
        pageControl.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingBottom: 5)
    }
    
    
}
