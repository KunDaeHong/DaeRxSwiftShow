//
//  SettingsService.swift
//  ShopUp
//
//  Created by HongDaehyeon on 2023/08/28.
//

import Foundation
import MessageUI

class SettingsService: NSObject, MFMailComposeViewControllerDelegate {
    public static let shared = SettingsService()
    
    static func sendMail(json: Dictionary<String, String>, vc: UIViewController) {
        if MFMailComposeViewController.canSendMail() {
            let mailSendVC = MFMailComposeViewController()
            mailSendVC.mailComposeDelegate = self.shared
            
            mailSendVC.setToRecipients(["emailAddress"])
            mailSendVC.setSubject("mailTitle")
            mailSendVC.setMessageBody("content", isHTML: false)
            
            vc.present(mailSendVC, animated: true, completion: nil)
        }
    }
}
