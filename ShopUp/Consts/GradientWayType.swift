//
//  GradientWayType.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2022/12/15.
//

import Foundation

enum GradientWayType {
    
    case LeftT
    case LeftB
    case Left
    case rightT
    case rightB
    case right
    case zero
    
    typealias RawValue = CGPoint
    
    init?(rawValue: CGPoint) {
        if rawValue == CGPoint.zero {
            self = .zero
        }else {
            return nil
        }
    }
    
    var rawValue: CGPoint {
        switch self {
        case .LeftT :
            return CGPoint(x: 0.0, y: 0.3)
        case .LeftB:
            return CGPoint(x: 0.0, y: 0.7)
        case .Left:
            return CGPoint(x: 0.0, y: 1.0)
        case .rightT:
            return CGPoint(x: 1.0, y: 0.3)
        case .rightB:
            return CGPoint(x: 1.0, y: 0.7)
        case .right:
            return CGPoint(x: 1.0, y: 1.0)
        case .zero :
            return CGPoint.zero
        }
    }
}
