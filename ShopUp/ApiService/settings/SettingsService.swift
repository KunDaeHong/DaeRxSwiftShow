//
//  SettingsService.swift
//  ShopUp
//
//  Created by HongDaehyeon on 2023/08/28.
//

import Foundation
import MessageUI
import UIKit

class SettingsService: NSObject, MFMailComposeViewControllerDelegate, WarningAlertFunctionDelegate{
    public static let shared = SettingsService()
    private var vc: UIViewController?
    
    func excuteConfirmFunc(sender: UIButton) {
        if let navCtrl = vc!.navigationController {
            navCtrl.popViewController(animated: true)
        }
    }
    
    public static func sendMail(json: Dictionary<String, String>, vc: UIViewController) {
        self.shared.vc = vc
        
        if MFMailComposeViewController.canSendMail() {
            let mailSendVC = MFMailComposeViewController()
            mailSendVC.mailComposeDelegate = self.shared
            
            mailSendVC.setToRecipients(["emailAddress"])
            mailSendVC.setSubject("mailTitle")
            mailSendVC.setMessageBody("content", isHTML: false)
            
            vc.present(mailSendVC, animated: true, completion: nil)
        }else {
            print("mail error")
            DispatchQueue.main.async {
                let alertMgr = WarningAlert(title: "에러", description: "테스트", confirmBtn: true)
                alertMgr.delegate = Self.shared
                alertMgr.frame = vc.view.frame
                UIApplication.shared.windows.first?.addSubview(alertMgr)
            }
        }
    }
}
