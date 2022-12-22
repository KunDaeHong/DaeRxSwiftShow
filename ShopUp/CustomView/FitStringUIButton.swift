//
//  FitStringUIButton.swift
//  ShopUp
//
//  Created by 파토스 on 2022/12/21.
//

import UIKit

class FitStringUIButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title : String) {
        self.init(frame: .zero)
        setupUI(title: title)
    }
    
    private func setupUI(title : String) {
        titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        setTitle(title, for: .normal)
        setTitleColor(.darkGray.withAlphaComponent(0.5), for: .normal)
        let buttonTitleSize = ((titleLabel?.text)! as NSString).size(withAttributes: [.font : UIFont.boldSystemFont(ofSize: 17 + 1)])
        var yPos: CGFloat = 40
        
        frame.size.height = buttonTitleSize.height * 2
        frame.size.width = buttonTitleSize.width
        frame.origin.x = 30
        
        yPos = yPos + (frame.size.height) + 10
        
        frame.origin.y = yPos
        tintColor = .black
        backgroundColor = .white
    }
}
