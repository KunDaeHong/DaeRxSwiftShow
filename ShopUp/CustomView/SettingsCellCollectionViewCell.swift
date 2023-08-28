//
//  SettingsCellCollectionViewCell.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2023/02/09.
//

import UIKit
import RxCocoa
import RxSwift

class SettingsCellCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
        
    }
    
    var tapHandler: (() -> Void)?
    
    //MARK: UI
    var topBanner: UIImageView?
    var title: UILabel?
    var subTitle: UILabel?
    var modiUIImage: UIImageView?
    var decideUIImage: UIImageView?
    var secondSubTitle: UILabel?
    var uiBtn: UIButton?
    
    //Rx
    var bag = DisposeBag()
    
    
    
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer){
        tapHandler!()
    }
    
    public func configureView(
        model: SettingsCellStuffModel,
        indexPath: IndexPath,
        lastIndex: Int,
        mainWidthSize: CGFloat,
        completionHandler: (() -> Void)? = nil
    ){
        var constraintList: [NSLayoutConstraint] = [
            widthAnchor.constraint(equalToConstant: mainWidthSize),
        ]
        
        if let touchUp = completionHandler {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_ :)))
            addGestureRecognizer(tapGesture)
            tapHandler = {touchUp()}
        }
        
        //Banner UI
        if model.imageCell{
            topBanner = UIImageView(image: model.image)
            topBanner!.translatesAutoresizingMaskIntoConstraints = false
            topBanner!.contentMode = .scaleAspectFill
            topBanner!.layer.cornerRadius = 41.5
            topBanner!.layer.masksToBounds = true
            addSubview(topBanner!)
            let tbConstraintList: [NSLayoutConstraint] = [
                heightAnchor.constraint(equalToConstant: 280),
                topBanner!.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                topBanner!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                topBanner!.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                topBanner!.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
            ]
            constraintList.append(contentsOf: tbConstraintList)
        }else{
            constraintList.append(heightAnchor.constraint(equalToConstant: 50))
        }
        
        //Title UI
        title = UILabel()
        title!.translatesAutoresizingMaskIntoConstraints = false
        title!.textColor = AppColorType.darkGrayFontColor.rawValue
        title!.font = .systemFont(ofSize: 17, weight: .regular)
        title!.text = model.title
        addSubview(title!)
        let titleConstraintList: [NSLayoutConstraint] = [
            title!.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            title!.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            title!.centerYAnchor.constraint(equalTo: centerYAnchor),
        ]
        
        constraintList.append(contentsOf: titleConstraintList)
        
        //subTitle UI
        if(model.subTitleOption && !model.imageCell){
            subTitle = UILabel(frame: self.frame)
            subTitle!.translatesAutoresizingMaskIntoConstraints = false
            subTitle!.textColor = AppColorType.darkGrayFontColor.rawValue
            subTitle!.font = .systemFont(ofSize: 17, weight: .regular)
            subTitle!.text = model.subTitle
            addSubview(subTitle!)
            let titleConstraintList: [NSLayoutConstraint] = [
                subTitle!.leadingAnchor.constraint(equalTo: title!.trailingAnchor, constant: 20),
                subTitle!.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
                subTitle!.centerYAnchor.constraint(equalTo: centerYAnchor),
            ]
            constraintList.append(contentsOf: titleConstraintList)
        }
        
        //modi, decide, second sub title UI
        if model.modifiedOption {
            let sizeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .small)
            let modiIcon: UIImage = UIImage(systemName: "pencil.circle.fill", withConfiguration: sizeConfig)!
            modiUIImage = UIImageView(image: modiIcon)
            modiUIImage!.translatesAutoresizingMaskIntoConstraints = false
            modiUIImage!.tintColor = AppColorType.darkGrayColor.rawValue
            addSubview(modiUIImage!)
            let modiConstraintList : [NSLayoutConstraint] = [
                modiUIImage!.centerYAnchor.constraint(equalTo: centerYAnchor),
                modiUIImage!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            ]
            constraintList.append(contentsOf: modiConstraintList)
        }
        
        if model.decideOption {
            let sizeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .small)
            let decideIcon: UIImage = UIImage(systemName: "checkmark.square.fill", withConfiguration: sizeConfig)!
            decideUIImage = UIImageView(image: decideIcon)
            decideUIImage!.translatesAutoresizingMaskIntoConstraints = false
            decideUIImage!.tintColor = AppColorType.redGradientSecondColor.rawValue
            if model.checkMark {
                decideUIImage!.tintColor = AppColorType.greenColor.rawValue
            }
            addSubview(decideUIImage!)
            let decideConstraintList : [NSLayoutConstraint] = [
                decideUIImage!.centerYAnchor.constraint(equalTo: centerYAnchor),
                decideUIImage!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            ]
            constraintList.append(contentsOf: decideConstraintList)
        }
        
        if model.secondSubTitleOption {
            secondSubTitle = UILabel()
            secondSubTitle!.translatesAutoresizingMaskIntoConstraints = false
            secondSubTitle!.textColor = AppColorType.darkGrayFontColor.rawValue
            secondSubTitle!.font = .systemFont(ofSize: 17, weight: .regular)
            secondSubTitle!.text = model.secondSubTitle
            addSubview(secondSubTitle!)
            let titleConstraintList: [NSLayoutConstraint] = [
                secondSubTitle!.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
                secondSubTitle!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                secondSubTitle!.centerYAnchor.constraint(equalTo: centerYAnchor),
            ]
            constraintList.append(contentsOf: titleConstraintList)
        }
        
        if model.handler != nil {
            uiBtn = UIButton()
            uiBtn!.titleLabel?.text = "확인"
            uiBtn!.titleLabel?.textColor = AppColorType.greenColor.rawValue
            uiBtn!.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
            uiBtn!.translatesAutoresizingMaskIntoConstraints = false
            addSubview(uiBtn!)
            let uiBtnConstraintList: [NSLayoutConstraint] = [
                uiBtn!.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
                uiBtn!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                uiBtn!.centerYAnchor.constraint(equalTo: centerYAnchor),
            ]
            constraintList.append(contentsOf: uiBtnConstraintList)
        }
        
        //모든 border는 이 형식으로...
        if indexPath.row + 1 != lastIndex && !model.imageCell{
            let border = CALayer()
            border.backgroundColor = AppColorType.darkGrayColor.rawValue.withAlphaComponent(0.2).cgColor
            //indexPath가 1부터 시작해서 이상하게 잡히는 듯함.
            border.frame = CGRect(x: 20, y: 50, width: mainWidthSize - 40, height: CGFloat(1))
            self.layer.insertSublayer(border, below: self.layer)
        }
        
        NSLayoutConstraint.activate(constraintList)
    }
    
    public func updateView(model: SettingsCellStuffModel){
        if model.imageCell{
            //Banner UI
            topBanner = UIImageView(image: model.image)
            topBanner!.contentMode = .scaleAspectFill
            
            return
        }
        //Title UI
        title!.textColor = AppColorType.darkGrayFontColor.rawValue
        title!.font = .systemFont(ofSize: 17, weight: .regular)
        title!.text = model.title
        
        //subTitle UI
        if(model.subTitleOption){
            subTitle = UILabel(frame: self.frame)
            subTitle!.textColor = AppColorType.darkGrayFontColor.rawValue
            subTitle!.font = .systemFont(ofSize: 17, weight: .regular)
            subTitle!.text = model.subTitle
        }
        
        //modi, decide, second sub title UI
        if model.modifiedOption {
            modiUIImage!.tintColor = AppColorType.darkGrayColor.rawValue
        }
        
        if model.decideOption {
            decideUIImage!.tintColor = AppColorType.redGradientSecondColor.rawValue
            if model.checkMark {
                decideUIImage!.tintColor = AppColorType.greenColor.rawValue
            }
        }
        
        if model.secondSubTitleOption {
            secondSubTitle!.textColor = AppColorType.darkGrayFontColor.rawValue
            secondSubTitle!.font = .systemFont(ofSize: 17, weight: .regular)
            secondSubTitle!.text = model.secondSubTitle
        }
        
        if model.handler != nil {
            uiBtn!.titleLabel?.text = "확인"
            uiBtn!.titleLabel?.textColor = AppColorType.greenColor.rawValue
            uiBtn!.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        }
    }
//    func generate(_ numRows: Int) -> [[Int]] {
//        var numArray : [[Int]] = Array(repeating: [1], count: numRows)
//
//        for firstRow in 0...numRows{
//            numArray[firstRow] = [Int](repeating: 1, count: firstRow+1)
//
//            for secondRow in numArray[firstRow]{
//                //numArray[firstRow][secondRow] =
//            }
//        }
//    }
}
