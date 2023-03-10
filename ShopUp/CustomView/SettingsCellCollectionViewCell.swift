//
//  SettingsCellCollectionViewCell.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2023/02/09.
//

import UIKit

class SettingsCellCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        //sender.completion!()
    }
    
    public func configureView(model: SettingsCellStuffModel, indexPath: IndexPath, lastIndex: Int, mainWidthSize: CGFloat){
        
        var constraintList: [NSLayoutConstraint] = [widthAnchor.constraint(equalToConstant: mainWidthSize)]
        
        if model.imageCell{
            //Banner UI
            let topBanner: UIImageView = UIImageView(image: model.image)
            topBanner.translatesAutoresizingMaskIntoConstraints = false
            topBanner.contentMode = .scaleAspectFill
            topBanner.layer.cornerRadius = 41.5
            topBanner.layer.masksToBounds = true
            addSubview(topBanner)
            let tbConstraintList: [NSLayoutConstraint] = [
                topBanner.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                topBanner.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                topBanner.heightAnchor.constraint(equalToConstant: 300),
                topBanner.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -70),
                heightAnchor.constraint(equalToConstant: 370),
            ]
            constraintList.append(contentsOf: tbConstraintList)
        }else{
            
            //Title UI
            let title: UILabel = UILabel(frame: frame)
            title.translatesAutoresizingMaskIntoConstraints = false
            title.textColor = AppColorType.darkGrayFontColor.rawValue
            title.font = .systemFont(ofSize: 17, weight: .regular)
            title.text = model.title
            addSubview(title)
            let titleConstraintList: [NSLayoutConstraint] = [
                title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                title.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
                title.centerYAnchor.constraint(equalTo: centerYAnchor),
                heightAnchor.constraint(equalToConstant: 50),
            ]
            constraintList.append(contentsOf: titleConstraintList)
            
            //subTitle UI
            if(model.subTitleOption){
                let subTitle: UILabel = UILabel(frame: frame)
                subTitle.translatesAutoresizingMaskIntoConstraints = false
                subTitle.textColor = AppColorType.darkGrayFontColor.rawValue
                subTitle.font = .systemFont(ofSize: 17, weight: .regular)
                subTitle.text = model.subTitle
                addSubview(subTitle)
                let titleConstraintList: [NSLayoutConstraint] = [
                    subTitle.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 20),
                    subTitle.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
                    subTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
                ]
                constraintList.append(contentsOf: titleConstraintList)
            }
            
            //modi, decide, second sub title UI
            if model.modifiedOption {
                let sizeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .small)
                let modiIcon: UIImage = UIImage(systemName: "pencil.circle.fill", withConfiguration: sizeConfig)!
                let modiUIImage: UIImageView = UIImageView(image: modiIcon)
                modiUIImage.translatesAutoresizingMaskIntoConstraints = false
                modiUIImage.tintColor = AppColorType.darkGrayColor.rawValue
                addSubview(modiUIImage)
                let modiConstraintList : [NSLayoutConstraint] = [
                    modiUIImage.centerYAnchor.constraint(equalTo: centerYAnchor),
                    modiUIImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                ]
                constraintList.append(contentsOf: modiConstraintList)
            }
            
            if model.decideOption {
                let sizeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .small)
                let decideIcon: UIImage = UIImage(systemName: "checkmark.square.fill", withConfiguration: sizeConfig)!
                let decideUIImage: UIImageView = UIImageView(image: decideIcon)
                decideUIImage.translatesAutoresizingMaskIntoConstraints = false
                decideUIImage.tintColor = AppColorType.redGradientSecondColor.rawValue
                if model.checkMark {
                    decideUIImage.tintColor = AppColorType.greenColor.rawValue
                }
                addSubview(decideUIImage)
                let decideConstraintList : [NSLayoutConstraint] = [
                    decideUIImage.centerYAnchor.constraint(equalTo: centerYAnchor),
                    decideUIImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                ]
                constraintList.append(contentsOf: decideConstraintList)
            }
            
            if model.secondSubTitleOption {
                let secondSubTitle: UILabel = UILabel()
                secondSubTitle.translatesAutoresizingMaskIntoConstraints = false
                secondSubTitle.textColor = AppColorType.darkGrayFontColor.rawValue
                secondSubTitle.font = .systemFont(ofSize: 17, weight: .regular)
                secondSubTitle.text = model.secondSubTitle
                addSubview(secondSubTitle)
                let titleConstraintList: [NSLayoutConstraint] = [
                    secondSubTitle.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
                    secondSubTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                    secondSubTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
                ]
                constraintList.append(contentsOf: titleConstraintList)
            }
            
            if model.handler != nil {
                let uiBtn: UIButton = UIButton()
                uiBtn.titleLabel?.text = "확인"
                uiBtn.titleLabel?.textColor = AppColorType.greenColor.rawValue
                uiBtn.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
                uiBtn.translatesAutoresizingMaskIntoConstraints = false
                addSubview(uiBtn)
                let uiBtnConstraintList: [NSLayoutConstraint] = [
                    uiBtn.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
                    uiBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                    uiBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
                ]
                constraintList.append(contentsOf: uiBtnConstraintList)
            }
            
            
            //모든 border는 이 형식으로...
            if indexPath.row + 1 != lastIndex {
                let border = CALayer()
                border.backgroundColor = AppColorType.darkGrayColor.rawValue.withAlphaComponent(0.2).cgColor
                border.frame = CGRectMake(20, self.frame.height - CGFloat(2) , mainWidthSize - 40, CGFloat(1))
                self.layer.addSublayer(border)
            }
            
        }
        NSLayoutConstraint.activate(constraintList)
    }
}
