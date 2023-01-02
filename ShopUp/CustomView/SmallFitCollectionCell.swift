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
    private let shape = CAShapeLayer()
    private var percentTage: Int = 0
    
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
        PercentTage: Int? = nil
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
        titleUI.text = title
        titleUI.translatesAutoresizingMaskIntoConstraints = false
        titleUI.textColor = .white
        titleUI.font = .systemFont(ofSize: 20, weight: .bold)
        titleUI.sizeToFit()
        
        let titleConstraintList: [NSLayoutConstraint] = [
            titleUI.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleUI.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleUI.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor)
        ]
        NSLayoutConstraint.activate(titleConstraintList)
        
        
        // image view
        if ImageView != nil && PercentTage == nil {
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
        if PercentTage != nil && ImageView == nil {
            //line shape
            shape.lineCap = .round
            shape.lineWidth = 10
            shape.strokeColor = AppColorType.whiteColor.rawValue.cgColor
            shape.fillColor = AppColorType.clear.rawValue.cgColor
            DispatchQueue.main.async {
                self.shape.path = self.getProgressPath(percentage: 100).cgPath
                self.progressAnimation(percentTage: CGFloat(100))
                self.shape.path = self.getProgressPath(percentage: PercentTage!).cgPath
                self.progressAnimation(percentTage: CGFloat(PercentTage!))
            }
        }
    }
    
    public func progressAnimation(percentTage: CGFloat) {
        //animation
        let animation = CAKeyframeAnimation(keyPath: "strokeEnd")
        animation.duration = 2.0
        animation.values = [0.0, 1.0, percentTage * 0.1]
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.repeatCount = 1
        shape.add(animation, forKey: "ProgressStrokeEnd")
        layer.addSublayer(shape)
    }
    
    private func getProgressPath(percentage: Int) -> UIBezierPath {
        let progressPath = UIBezierPath()
        let viewCenter = CGPoint(x: bounds.midX, y: bounds.maxY - 30)
        //endAngle엔 startAngle값을 더해야 endAngle에서 0으로 계산되는게 아닌 180(시작 각도)부터 계산됨.
        progressPath.addArc(withCenter: viewCenter, radius: 33, startAngle: 180 / 180 * .pi, endAngle: ((CGFloat(percentage) / 100 * 180) + 180) / 180 * .pi, clockwise: true)
        return progressPath
    }
    
    
}
