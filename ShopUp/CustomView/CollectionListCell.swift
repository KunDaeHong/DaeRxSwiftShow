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
    
    var tapHandler: (() -> Void)?
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer){
        if let touchUp = tapHandler {
            touchUp()
        }
    }
    
    public func configureCell(
        title: String, indexPath: IndexPath,
        lastIndex: Int = 0, border: Bool = false,
        borderWidth: Int = 1,
        completionHandler: (() -> Void)? = nil
    ){
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
            if indexPath.row + 1 != lastIndex {
                let border = CALayer()
                border.backgroundColor = AppColorType.darkGrayColor.rawValue.withAlphaComponent(0.2).cgColor
                border.frame = CGRectMake(20, self.frame.height - CGFloat(borderWidth) , self.frame.width - 20, CGFloat(borderWidth))
                self.layer.addSublayer(border)
            }
        }
        
        if let touchUp = completionHandler {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_ :)))
            addGestureRecognizer(tapGesture)
            tapHandler = touchUp
        }
        
    }
}
