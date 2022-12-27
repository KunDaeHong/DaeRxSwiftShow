//
//  FoodInfomationDBModel.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2022/12/26.
//

import Foundation
import RealmSwift

class FoodInfomationDBModel : Object {
    @objc dynamic var idx : Int = 0
    @objc dynamic var title : String = ""
    @objc dynamic var subscription : String = ""
    @objc dynamic var date : Date = Date()
    
    override static func primaryKey() -> String? {
        return "idx"
    }
}
