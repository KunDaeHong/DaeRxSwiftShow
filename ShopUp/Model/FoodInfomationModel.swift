//
//  FoodInfomationModel.swift
//  ShopUp
//
//  Created by Daehyeoh Hong on 2022/12/23.
//

import Foundation

struct FoodInfomationModel {
    let title : String
    let subscription : String
    let date: Date
    
    init(
        title: String,
        subscription: String,
        date : Date
    ) {
        self.title = title
        self.subscription = subscription
        self.date = date
    }
}
