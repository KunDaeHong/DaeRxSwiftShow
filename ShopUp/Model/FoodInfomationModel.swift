//
//  FoodInfomationModel.swift
//  ShopUp
//
//  Created by Daehyeoh Hong on 2022/12/23.
//

import Foundation

struct FoodInfomationModel {
    let idx : Int
    let title : String
    let subscription : String
    let date: Date
    
    init(
        idx : Int,
        title: String,
        subscription: String,
        date : Date
    ) {
        self.idx = idx
        self.title = title
        self.subscription = subscription
        self.date = date
    }
}
