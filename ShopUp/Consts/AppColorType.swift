//
//  AppColorType.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2022/12/23.
//

import Foundation
import UIKit

enum AppColorType {
    
    //uiColor
    case blackColor
    case darkGrayColor
    case whiteColor
    case greenColor
    case orangeColor
    case halfBlackColor
    case halfDarkGrayColor
    
    //gradientColor
    case redGradientFirstColor
    case redGradientSecondColor
    case orangeGradientFirstColor
    case orangeGradientSecondColor
    case greenGradientFirstColor
    case greenGradientSecondColor
    case grayGradientFirstColor
    case grayGradientSecondColor
    
    //fontColor
    case halfWhiteFontColor
    case halfBlackFontColor
    case darkGrayFontColor
    case whiteFontColor
    case blackFontColor
    
    //nil
    case clear
    
    typealias RawValue = UIColor
    
    init?(rawValue: UIColor){
        if rawValue == UIColor.clear {
            self = .clear
        }else {
            return nil
        }
    }
    
    //rawValue를 붙이는 이유는 기존 UIColor로 쓰는 경우에 AppColorType은 전혀 다른 타입으로 인식하기에
    //rawValue를 UIColor로 반환해주어야 합니다.
    var rawValue: UIColor {
        switch self {
            
        //UIColor
        case .blackColor :
            return .black
        case .darkGrayColor :
            return UIColor(rgb: "35363a")
        case .whiteColor :
            return .white
        case .greenColor :
            return UIColor(rgb: "7be080")
        case .orangeColor :
            return UIColor(rgb: "f7a05e")
        case .halfBlackColor :
            return .black.withAlphaComponent(0.6)
        case .halfDarkGrayColor :
            return UIColor(rgb: "35363a").withAlphaComponent(0.6)
            
        //GradientColor
        case .redGradientFirstColor :
            return UIColor(rgb: "f56056")
        case .redGradientSecondColor :
            return UIColor(rgb: "ffa9a3")
        case .orangeGradientFirstColor :
            return UIColor(rgb: "e8b980")
        case .orangeGradientSecondColor :
            return UIColor(rgb: "ebc698")
        case .greenGradientFirstColor:
            return UIColor(rgb: "51c259")
        case .greenGradientSecondColor:
            return UIColor(rgb: "75e86b")
        case .grayGradientFirstColor :
            return UIColor(rgb: "8c8c8c")
        case .grayGradientSecondColor :
            return UIColor(rgb: "a6a6a6")
            
        //Font Color
        case .halfWhiteFontColor:
            return UIColor.white.withAlphaComponent(0.5)
        case .halfBlackFontColor:
            return UIColor.black.withAlphaComponent(0.5)
        case .darkGrayFontColor:
            return UIColor(rgb: "35363a")
        case .whiteFontColor:
            return UIColor.white
        case .blackFontColor:
            return UIColor.black
        case .clear:
            return UIColor.clear
        }
    }
}
