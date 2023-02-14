//
//  UserSettingsView.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2023/02/07.
//

import UIKit

class UserSettingsView: UIView {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = AppColorType.whiteColor.rawValue
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureView() {
        
    }

}
