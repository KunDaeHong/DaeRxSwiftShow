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
    var app_version: String = "0.0.2"
    var app_resources_version: String = "0.0.1"
    var app_version_warranty: Bool = true
    
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
    
    //MARK: App Error Analytics
    var app_collect_errors: Bool = true
    
    //MARK: Caution! Developer Mode
    var developer_mode: Bool = false
    
}

enum weather_enum : Int32{
    case winter = 0
    case spring = 1
    case summer = 2
    case autumn = 3
    case nothing = 4
}
