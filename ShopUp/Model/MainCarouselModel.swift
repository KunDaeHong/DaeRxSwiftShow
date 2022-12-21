//
//  MainCarouselModel.swift
//  ShopUp
//
//  Created by 파토스 on 2022/12/15.
//

import Foundation

struct MainCarouselModel : Decodable {
    let idx: Int
    let title: String
    let subTitle: String
    let firstColor: String
    let secondColor: String
    
    private enum Keys: String, CodingKey {
        case idx
        case title
        case subTitle
        case firstColor
        case secondColor
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        self.idx         = try container.decode(Int.self, forKey: .idx)
        self.title       = try container.decode(String.self, forKey: .title)
        self.subTitle    = try container.decode(String.self, forKey: .subTitle)
        self.firstColor  = try container.decode(String.self, forKey: .firstColor)
        self.secondColor = try container.decode(String.self, forKey: .secondColor)
    }
}
