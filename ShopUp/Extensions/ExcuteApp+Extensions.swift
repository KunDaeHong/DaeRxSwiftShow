//
//  ExcuteApp+Extensions.swift
//  ShopUp
//
//  Created by HongDaehyeon on 2023/09/04.
//

import Foundation
import UIKit

class ExcuteExtension {
    
    public static let shared = ExcuteExtension()
    
    
    public static func executeSchemeApp(scheme: String) {
        let schemeUrl = URL(string: scheme)!
        if UIApplication.shared.canOpenURL(schemeUrl) {
            print("")
            print("--------")
            print("ExcuteExtension [executeSchemeApp] 외부 앱 실행")
            print("--------")
            if #available(iOS 10.0, *){
                UIApplication.shared.open(schemeUrl, options: [:], completionHandler: nil)
            }else {
                UIApplication.shared.openURL(schemeUrl)
            }
            
        }else{
            print("")
            print("--------")
            print("ExcuteExtension [executeSchemeApp] 외부 앱 실행 오류")
            print("--------")
            print("No exist \(scheme) app. Please check the app or check info.plist")
        }
    }
    
    // Apple Native app Excute
    
    
}
