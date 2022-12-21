//
//  UIView+Extensions.swift
//  ShopUp
//
//  Created by 홍대현 on 2022/12/15.
//

import Foundation
import UIKit

extension UIView {
    func setTwoGradientUIView(firstColor: UIColor, secondColor: UIColor, firstPosition: GradientWayType, secondPosition: GradientWayType) {
        backgroundColor = .clear
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [firstColor, secondColor]
        gradient.startPoint = firstPosition.rawValue
        gradient.endPoint = secondPosition.rawValue
        gradient.locations = [0, 1]
        self.layer.addSublayer(gradient)
    }
}
