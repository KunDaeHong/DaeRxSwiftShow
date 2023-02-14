//
//  PreviewImgCollectionViewCell.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2023/02/09.
//

import UIKit

class PreviewImgCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(img: UIImage, title: String, subTitle: String) {
        let imageView: UIImageView = UIImageView(image: img)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 41.5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraintList: [NSLayoutConstraint] = [
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 15)
        ]
        NSLayoutConstraint.activate(constraintList)
        
        //top
        let topGradientLayer = CAGradientLayer()
        topGradientLayer.colors = [AppColorType.clear.rawValue.cgColor, UIColor.init(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor]
        topGradientLayer.startPoint = GradientWayType.LeftT.rawValue
        topGradientLayer.endPoint = GradientWayType.LeftB.rawValue
        topGradientLayer.locations = [0.0, 0.2, 1.0]
        topGradientLayer.frame = imageView.frame
        imageView.layer.mask = topGradientLayer
        
        //bottom
        let bottomGradientLayer = CAGradientLayer()
        bottomGradientLayer.colors = [AppColorType.clear.rawValue.cgColor, UIColor.init(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor]
        bottomGradientLayer.startPoint = GradientWayType.LeftB.rawValue
        bottomGradientLayer.endPoint = GradientWayType.LeftT.rawValue
        bottomGradientLayer.locations = [0.0, 0.2, 1.0]
        bottomGradientLayer.frame = imageView.frame
        imageView.layer.mask = bottomGradientLayer
    }
}
