//
//  AllStatusModel.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2022/12/27.
//

import Foundation
import UIKit

struct AllStatusModel {
    let title: String
    let image: UIImage?
    let percentage: Int?
    
    init(title: String, image: UIImage?, percentage: Int?) {
        self.title = title
        self.image = image
        self.percentage = percentage
    }
}
