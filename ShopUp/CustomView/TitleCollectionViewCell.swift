//
//  TitleCollectionViewCell.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2023/01/26.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(
        mainTitle: String,
        subTitle: String,
        modify: Bool = false,
        border: Bool = false,
        borderWidth: Int = 0,
        indexPath: IndexPath = IndexPath(),
        listCount: Int = 0
    ) {
        
        let mainTitleView = UILabel()
        mainTitleView.text = mainTitle
        mainTitleView.font = .systemFont(ofSize: 17, weight: .regular)
        mainTitleView.textColor = AppColorType.blackColor.rawValue
        mainTitleView.translatesAutoresizingMaskIntoConstraints = false
        
        let subTitleView = UILabel()
        subTitleView.text = subTitle
        subTitleView.font = .systemFont(ofSize: 17, weight: .regular)
        subTitleView.textColor = AppColorType.halfBlackFontColor.rawValue
        subTitleView.translatesAutoresizingMaskIntoConstraints = false
        
        var nsLayoutConstraintList: [NSLayoutConstraint] = [
            mainTitleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            mainTitleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainTitleView.trailingAnchor.constraint(lessThanOrEqualTo: subTitleView.leadingAnchor),
            subTitleView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            subTitleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ]
        
        if modify {
            let modiIcon = UIImageView(frame: .init(x: 0, y: 0, width: 50, height: 50))
            modiIcon.image = UIImage(systemName: "square.and.pencil")
            modiIcon.contentMode = .scaleAspectFill
            modiIcon.translatesAutoresizingMaskIntoConstraints = false
            
            let dividerWithIcon = UIView(frame: .init(x: 0, y: 0, width: borderWidth, height: 35))
            dividerWithIcon.backgroundColor = AppColorType.darkGrayColor.rawValue.withAlphaComponent(0.2)
            dividerWithIcon.translatesAutoresizingMaskIntoConstraints = false
            
            let nsLayoutModifyList: [NSLayoutConstraint] = [
                modiIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                modiIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
                modiIcon.leadingAnchor.constraint(equalTo: dividerWithIcon.trailingAnchor, constant: 10),
                dividerWithIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
                subTitleView.trailingAnchor.constraint(equalTo: dividerWithIcon.leadingAnchor, constant: 10)
            ]
            nsLayoutConstraintList.append(contentsOf: nsLayoutModifyList)
        }else {
            nsLayoutConstraintList.append(subTitleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0))
        }
        
        NSLayoutConstraint.activate(nsLayoutConstraintList)
        
        if border {
            if indexPath.row + 1 != listCount {
                let border = CALayer()
                border.backgroundColor = AppColorType.darkGrayColor.rawValue.withAlphaComponent(0.2).cgColor
                border.frame = CGRectMake(20, self.frame.height - CGFloat(borderWidth) , self.frame.width - 20, CGFloat(borderWidth))
                self.layer.addSublayer(border)
            }
        }
        
    }
}
