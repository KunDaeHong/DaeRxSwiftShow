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
        
        let titleLabel: UILabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = AppColorType.whiteFontColor.rawValue
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        titleLabel.text = title
        
        let subTitleLabel: UILabel = UILabel()
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.textColor = AppColorType.whiteColor.rawValue
        subTitleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        subTitleLabel.text = subTitle
        
        let constraintList: [NSLayoutConstraint] = [
            //이미지부분 오토레이아웃 부분
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            //제목 부분 오토레이아웃 부분
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            //서브 제목 부분 오토레이아웃 부분
            subTitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            subTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
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
