//
//  SettingsViewController.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2022/12/26.
//

import UIKit

class SettingsViewController: UIViewController {

    ///SettingsViewController Main Views
    
    ///Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    //View Action
    @IBAction func GoingToBack(_ sender: Any) {
        if let navCtrl = self.navigationController {
            navCtrl.popViewController(animated: true)
        }
    }
}
