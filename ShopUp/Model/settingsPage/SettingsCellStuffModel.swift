//
//  SettingsCellStuffModel.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2023/02/09.
//

import UIKit

struct SettingsCellStuffModel {
    var title: String
    var subTitleOption: Bool
    var subTitle: String
    var modifiedOption: Bool
    var decideOption: Bool
    var checkMark: Bool
    var secondSubTitleOption: Bool
    var secondSubTitle: String
    var handler: Void?
    var imageCell: Bool
    var image: UIImage
    
    init(title: String, subTitleOption: Bool = true, subTitle: String = "", modifiedOption: Bool = false, decideOption: Bool = false,
         checkMark: Bool = false, secondSubTitleOption: Bool = false, secondSubTitle: String = "", handler: Void? = nil, imageCell: Bool = false, image: UIImage = UIImage()) {
        self.title = title
        self.subTitleOption = subTitleOption
        self.subTitle = subTitle
        self.modifiedOption = modifiedOption
        self.decideOption = decideOption
        self.checkMark = checkMark
        self.secondSubTitleOption = secondSubTitleOption
        self.secondSubTitle = secondSubTitle
        self.handler = handler
        self.imageCell = imageCell
        self.image = image
    }
    
}
