//
//  CollectionListCell.swift
//  ShopUp
//
//  Created by 파토스 on 2023/01/04.
//

import UIKit

class CollectionListCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(
        title: String, indexPath: IndexPath,
        lastIndex: Int = 0, border: Bool = false,
        borderWidth: Int = 1){
        let mainTitle = UILabel()
        mainTitle.text = title
        mainTitle.textColor = AppColorType.darkGrayFontColor.rawValue
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainTitle)
        
        let constraintList : [NSLayoutConstraint] = [
            mainTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainTitle.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            mainTitle.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraintList)
        
        if border {
            if indexPath.last != lastIndex {
                let border = CALayer()
                border.backgroundColor = AppColorType.darkGrayColor.rawValue.withAlphaComponent(0.2).cgColor
                border.frame = CGRectMake(20, self.frame.height - CGFloat(borderWidth) , self.frame.width - 20, CGFloat(borderWidth))
                self.layer.addSublayer(border)
            }
        }
        
    }
    
}
