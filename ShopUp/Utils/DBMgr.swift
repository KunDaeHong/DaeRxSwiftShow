//
//  DBMgr.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2022/12/26.
//

import Foundation
import RealmSwift

class DBMgr {
    //shared 으로 전역에서 공통으로 사용할 수 있도록 셋팅
    public static let shared = DBMgr()
    private let realm = try! Realm()
    
    func saveFoodList(saveObjects: FoodInfomationModel) {
        let lastObject = realm.objects(FoodInfomationDBModel.self).sorted(byKeyPath: "idx", ascending: false).first?.idx ?? 0
        let newObject = FoodInfomationDBModel()
        newObject.idx = lastObject == 0 ? 0 : lastObject + 1
        newObject.title = saveObjects.title
        newObject.subscription = saveObjects.subscription
        newObject.date = saveObjects.date
        try! realm.write {
            realm.add(newObject)
        }
    }
    
    func getFoodListCount() -> Int {
        let lastObjectNumber: Int = realm.objects(FoodInfomationDBModel.self).count
        return lastObjectNumber
    }
}
