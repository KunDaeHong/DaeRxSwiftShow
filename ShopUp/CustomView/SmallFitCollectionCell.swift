//
//  SmallFitCollectionCell.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2022/12/27.
//

import Foundation
import UIKit

class SmallFitCollectionCell: UICollectionViewCell {
    private let customView: UIView = UIView()
    
    static let cellId = "SmallFitCollectCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(
        //Just Title
        title: String,
        // First gradient color. But solid color fills up automatically if you don't use the second color parameter. Use a second color if you want a gradient color.
        firstColor: AppColorType,
        // Gradient second color.
        secondColor: AppColorType = .clear,
        // First gradient color direction.
        gradientFirstDirection: GradientWayType = .zero,
        // Second gridient color direction.
        gradientSecondDirection: GradientWayType = .zero,
        // Use an image or icon in the background if you want to. However it will automatically render as a gradient in the background.
        ImageView: UIImageView? = nil,
        // Use a percent view in the background if you want. But see percent view if you want to see.
        PersentTage: Int? = nil
    ){
        //Cell View settings
        self.clipsToBounds = true
        // iPhone shape or apps shape with default corner radius.
        self.layer.cornerRadius = 41.5
        if secondColor != .clear {
            self.setTwoGradientUICollectionCell(
                firstColor: firstColor.rawValue,
                secondColor: secondColor.rawValue,
                firstPosition: gradientFirstDirection,
                secondPosition: gradientSecondDirection)
        }else{
            backgroundColor = firstColor.rawValue
        }
        
        // MARK: Cell widgets
        // title
        let titleUI: UILabel = UILabel()
        addSubview(titleUI)
        titleUI.translatesAutoresizingMaskIntoConstraints = false
        titleUI.textColor = .white
        titleUI.font = .systemFont(ofSize: 15, weight: .bold)
        titleUI.sizeToFit()
        
        let titleConstraintList: [NSLayoutConstraint] = [
            titleUI.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleUI.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleUI.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor)
        ]
        NSLayoutConstraint.activate(titleConstraintList)
        
        
        // image view
        if ImageView != nil && PersentTage == nil {
            addSubview(ImageView!)
            ImageView?.translatesAutoresizingMaskIntoConstraints = false
            ImageView?.contentMode = .scaleAspectFit
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = ImageView!.bounds
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.withAlphaComponent(0.0).cgColor]
            gradientLayer.startPoint = GradientWayType.LeftB.rawValue
            gradientLayer.endPoint = GradientWayType.rightT.rawValue
            ImageView!.layer.mask = gradientLayer
            
            let imageViewConstraintList: [NSLayoutConstraint] = [
                ImageView!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                ImageView!.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
                ImageView!.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
                ImageView!.widthAnchor.constraint(equalToConstant: 30),
                ImageView!.heightAnchor.constraint(equalToConstant: 30),
            ]
            NSLayoutConstraint.activate(imageViewConstraintList)
        }
        
        
        //percentage view
        if PersentTage != nil && ImageView == nil {
            //main view
            let mainView = UIView()
            addSubview(mainView)
            mainView.translatesAutoresizingMaskIntoConstraints = false
            
            let mainViewConstraintList: [NSLayoutConstraint] = [
                mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
                mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
                mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
                mainView.heightAnchor.constraint(equalToConstant: 30),
            ]
            NSLayoutConstraint.activate(mainViewConstraintList)
            
            //half circle path
            let halfCirclePath = UIBezierPath()
            halfCirclePath.move(to: center)
            halfCirclePath.addArc(withCenter: center, radius: mainView.frame.width / 2, startAngle: .pi, endAngle: 2 * .pi, clockwise: true)
            halfCirclePath.lineCapStyle = .round
            
            
            //line shape
            let shape = CAShapeLayer()
            shape.lineWidth = 3
            shape.path = halfCirclePath.cgPath
            shape.strokeColor = AppColorType.whiteColor.rawValue.cgColor
            mainView.layer.addSublayer(shape)
            
            
            //animation
            let animation = CAKeyframeAnimation(keyPath: "percent")
            animation.values = [0.0, 1.0, PersentTage!/100]
            animation.keyTimes = [0, 0.5, 1]
            animation.duration = 0.5
            animation.isAdditive = true
            shape.add(animation, forKey: "halfCirclePercent")
        }
        
    }
}
