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
            ImageView?.tintColor = AppColorType.clear.rawValue
            
            
            let imageViewConstraintList: [NSLayoutConstraint] = [
                ImageView!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                ImageView!.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
                ImageView!.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
                ImageView!.widthAnchor.constraint(equalToConstant: 50),
                ImageView!.heightAnchor.constraint(equalToConstant: 50),
            ]
            NSLayoutConstraint.activate(imageViewConstraintList)
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [AppColorType.clear.rawValue.cgColor, AppColorType.halfDarkGrayColor.rawValue.cgColor]
            gradientLayer.startPoint = GradientWayType.LeftT.rawValue
            gradientLayer.endPoint = GradientWayType.rightB.rawValue
            gradientLayer.frame = ImageView!.frame
            
            let mask = CALayer()
            mask.contents = ImageView?.image?.cgImage
            mask.frame = gradientLayer.bounds
            
            gradientLayer.mask = mask
            
            ImageView?.layer.addSublayer(gradientLayer)
            
            
        }
        
        
        //percentage view
        if PercentTage != nil && ImageView == nil {
            //line shape
            let progressNumUI: UILabel = UILabel()
            addSubview(progressNumUI)
            progressNumUI.text = "\(PercentTage!)"
            progressNumUI.translatesAutoresizingMaskIntoConstraints = false
            progressNumUI.textColor = .white
            progressNumUI.font = .systemFont(ofSize: 20, weight: .bold)
            progressNumUI.sizeToFit()
            
            let progressConstraintList: [NSLayoutConstraint] = [
                progressNumUI.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
                progressNumUI.centerXAnchor.constraint(equalTo: centerXAnchor)
            ]
            NSLayoutConstraint.activate(progressConstraintList)
            
            shape.lineCap = .round
            shape.lineWidth = 10
            shape.strokeColor = AppColorType.whiteColor.rawValue.cgColor
            shape.fillColor = AppColorType.clear.rawValue.cgColor
            layer.addSublayer(shape)
            shape.path = getProgressPath(percentage: 100).cgPath
            progressAnimation(percentTage: CGFloat(100), first: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                self.progressAnimation(percentTage: CGFloat(PercentTage!), first: false)
            }
        }
    }
    
    public func progressAnimation(percentTage: CGFloat, first: Bool) {
        //animation
        var fromValue = shape.strokeEnd
        let toValue = percentTage * 0.01
        if let presentationLayer = shape.presentation() {
            fromValue = presentationLayer.strokeEnd
        }
        let duration = first ? 1.5 : 0.5
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = first ? 0 : fromValue
        animation.toValue = toValue
        animation.duration = duration
        shape.removeAnimation(forKey: "ProgressStrokeEnd")
        shape.add(animation, forKey: "ProgressStrokeEnd")
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        shape.strokeEnd = toValue
        CATransaction.commit()
    }
    
    private func getProgressPath(percentage: Int) -> UIBezierPath {
        let progressPath = UIBezierPath()
        let viewCenter = CGPoint(x: bounds.midX, y: bounds.maxY - 30)
        //endAngle엔 startAngle값을 더해야 endAngle에서 0으로 계산되는게 아닌 180(시작 각도)부터 계산됨.
        progressPath.addArc(withCenter: viewCenter, radius: 33, startAngle: 180 / 180 * .pi, endAngle: ((CGFloat(percentage) / 100 * 180) + 180) / 180 * .pi, clockwise: true)
        return progressPath
    }
    
    
}
