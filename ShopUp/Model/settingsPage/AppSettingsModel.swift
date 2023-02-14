//
//  AppSettingsModel.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2023/01/17.
//

import Foundation

struct AppSettingsModel {
    
    let userName: String
    let birthday: String
    let weatherAutonomus: Bool
    let weatherManually: [String: Any]
    let alert: Bool
    let alertVib: Bool
    let alertSound: Bool
    let securityAnalytics: Bool
    let safeMode: Bool
    let developerMode: Bool
    
    init(userName: String, birthday: String, weatherAutonomus: Bool, weatherManually: [String : Any], alert: Bool, alertVib: Bool, alertSound: Bool, securityAnalytics: Bool, safeMode: Bool, developerMode: Bool) {
        self.userName = userName
        self.birthday = birthday
        self.weatherAutonomus = weatherAutonomus
        self.weatherManually = weatherManually
        self.alert = alert
        self.alertVib = alertVib
        self.alertSound = alertSound
        self.securityAnalytics = securityAnalytics
        self.safeMode = safeMode
        self.developerMode = developerMode
    }
}
