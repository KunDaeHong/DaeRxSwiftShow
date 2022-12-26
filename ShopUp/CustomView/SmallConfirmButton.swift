//
//  SmallConfirmButton.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2022/12/23.
//

import UIKit

class SmallConfirmButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title : String, font: UIFont, color: AppColorType) {
        self.init(frame: .zero)
        setupUI(title: title, font: font, color: color.rawValue)
    }
    
    private func setupUI(title : String, font: UIFont, color: UIColor) {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = font
        setTitleColor(color, for: .normal)
        setTitle(title, for: .normal)
        titleLabel?.textAlignment = .center
        let buttonTitleSize = ((titleLabel?.text)! as NSString).size(withAttributes: [.font : font])
        var yPos: CGFloat = 40

        frame.size.height = buttonTitleSize.height * 2
        frame.size.width = buttonTitleSize.width + 20
        frame.origin.x = 30
        
        yPos = yPos + (frame.size.height) + 10
        
        frame.origin.y = yPos
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = frame.size.height / 3
    }

}
