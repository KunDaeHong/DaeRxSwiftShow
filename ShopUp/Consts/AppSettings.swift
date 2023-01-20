//
//  AppSettings.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2023/01/19.
//

import Foundation

struct AppSettings {
    
    public static let shared = AppSettings()
    
    //MARK: User With App Infomation
    var app_version: String = ""
    var user_name: String = ""
    var user_birthday: String = ""
    
    //MARK: Weather With display Options
    var dark_theme: Bool = true
    var weather_auto: Bool = true
    var weather_manually: Bool = false
    var weather_manually_detail: String = "SPRING"
    
    //MARK: Alert Options
    var alert: Bool = true
    var alert_vib: Bool = true
    var alert_sound: Bool = true
    var security_app_analytics: Bool = true
    
    //MARK: Caution! Developer Mode
    var developer_mode: Bool = false
    
}
