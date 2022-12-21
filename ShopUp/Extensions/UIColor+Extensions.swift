//
//  UIColor+Extensions.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2022/12/15.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "invalid red color component")
        assert(green >= 0 && green <= 255, "invaild green color component")
        assert(blue >= 0 && blue <= 255, "invalid blue color component")
        
        self.init(red: CGFloat(red) / 225.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int){
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init(rgb: String){
        let scanner = Scanner(string: rgb)
        var hexNum: UInt64 = 0
        
        scanner.scanHexInt64(&hexNum)
        let r = Int(hexNum >> 16) & 0xFF
        let g = Int(hexNum >> 8) & 0xFF
        let b = Int(hexNum) & 0xFF
        
        self.init(red: r, green: g, blue: b)
    }
}
