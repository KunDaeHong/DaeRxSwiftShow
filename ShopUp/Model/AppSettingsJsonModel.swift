//
//  AppSettingsJsonModel.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2023/01/17.
//

import Foundation

struct AppSettingsJsonModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case settingsName
        case turnOnOff
        case detail
    }
    
    let settingsName: String
    let turnOnOff: Bool
    let detail: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        settingsName = try container.decode(String.self, forKey: .settingsName)
        turnOnOff = try container.decode(Bool.self, forKey: .turnOnOff)
        detail = try container.decode(String.self, forKey: .detail)
    }
}
