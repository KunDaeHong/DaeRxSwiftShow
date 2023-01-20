//
//  AppSettingsDBModel.swift
//  ShopUp
//
//  Created by 파토스 on 2023/01/17.
//

import UIKit
import RealmSwift

class AppSettingsDBModel: Object {
    @objc dynamic var settingsName: String = ""
    @objc dynamic var turnOnOff: Bool = false
    @objc dynamic var detail: String = ""
    
    override static func primaryKey() -> String {
        return "settngsName"
    }
}
