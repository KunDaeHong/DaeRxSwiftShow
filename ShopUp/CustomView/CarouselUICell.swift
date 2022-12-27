//
//  CarouselUICell.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2022/12/15.
//

import Foundation
import UIKit

class CarouselUICell: UICollectionViewCell {
    private let customView = UIView()
    
    static let cellId = "carouselCell"
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        customView.clipsToBounds = true
        customView.layer.cornerRadius = 41.5
    }
    
    public func configure(view: UIView, title: String, subTitle: String){
        //Cell View Settings
        self.setTwoGradientUICollectionCell(
            firstColor: AppColorType.redGradientFirstColor.rawValue,
            secondColor: AppColorType.redGradientSecondColor.rawValue,
            firstPosition: .LeftB,
            secondPosition: .rightT)
        self.clipsToBounds = true
        self.layer.cornerRadius = 41.5
        
        //내부 내용
        let titleUI : UILabel = UILabel(frame: frame)
        let subTitleUI: UILabel = UILabel(frame: frame)
        
        addSubview(titleUI)
        addSubview(subTitleUI)
        
        titleUI.translatesAutoresizingMaskIntoConstraints = false
        titleUI.textColor = .init(white: 1, alpha: 0.4)
        titleUI.text = title
        titleUI.font = .systemFont(ofSize: 40.0, weight: .bold)
        titleUI.lineBreakMode = .byTruncatingTail
        titleUI.numberOfLines = 0
        titleUI.sizeToFit()
        
        subTitleUI.translatesAutoresizingMaskIntoConstraints = false
        subTitleUI.textColor = .init(white: 1, alpha: 1)
        subTitleUI.text = subTitle
        subTitleUI.font = .systemFont(ofSize: 40.0, weight: .bold)
        subTitleUI.lineBreakMode = .byTruncatingTail
        subTitleUI.numberOfLines = 0
        subTitleUI.sizeToFit()
        
        let configurationConstraint = [
            titleUI.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleUI.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleUI.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            subTitleUI.topAnchor.constraint(equalTo: titleUI.bottomAnchor, constant: 13),
            subTitleUI.leadingAnchor.constraint(equalTo: titleUI.leadingAnchor),
            subTitleUI.trailingAnchor.constraint(equalTo: titleUI.trailingAnchor),
        ]
        NSLayoutConstraint.activate(configurationConstraint)
    }
}
