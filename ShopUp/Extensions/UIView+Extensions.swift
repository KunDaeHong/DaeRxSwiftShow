//
//  UIView+Extensions.swift
//  ShopUp
//
//  Created by 홍대현 on 2022/12/15.
//

import Foundation
import UIKit

///UI View Extension
extension UIView {
    func setTwoGradientUIView(
        firstColor: UIColor,
        secondColor: UIColor,
        firstPosition: GradientWayType,
        secondPosition: GradientWayType) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = firstPosition.rawValue
        gradient.endPoint = secondPosition.rawValue
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}
