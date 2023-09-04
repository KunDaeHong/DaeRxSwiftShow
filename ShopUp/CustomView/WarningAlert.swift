//
//  WarningAlert.swift
//  ShopUp
//
//  Created by HongDaehyeon on 2023/09/04.
//

//viewController 형식으로 변경될 예정

import UIKit

///Delegate로 Alert에서 함수를 작동시키로 싶을 때 사용합니다.
protocol WarningAlertFunctionDelegate {
    func excuteConfirmFunc(sender: UIButton)
}

class WarningAlert: UIView {
    
    /*---------------------------------------------------------------------------*
       * 오류 또는 확인을 누를 때 사용하는 view
    *---------------------------------------------------------------------------*/
    var delegate: WarningAlertFunctionDelegate?
    var confirmBtn: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(title: String, description: String, confirmBtn: Bool){
        self.init(frame: .zero)
        self.confirmBtn = confirmBtn
        self.viewSettings(title: title, description: description, confirmBtn: confirmBtn)
        
    }
    
    private func viewSettings(title: String, description: String, confirmBtn: Bool) {
        let mainAlertView = UIView(frame: CGRect(x: 0, y: 0, width: Int(self.frame.width/2), height: Int(self.frame.height/3)))
        let confirmBtn = SmallConfirmButton(title: "확인", font: .systemFont(ofSize: 20.0, weight: .bold), color: .whiteFontColor)
        
        
        self.addSubview(mainAlertView)
        mainAlertView.addSubview(confirmBtn)
        
        mainAlertView.translatesAutoresizingMaskIntoConstraints = false
        mainAlertView.clipsToBounds = true
        mainAlertView.layer.cornerRadius = 41.5
        mainAlertView.backgroundColor = AppColorType.whiteColor.rawValue
        
        confirmBtn.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        
        let constraintList: [NSLayoutConstraint] = [
            confirmBtn.leadingAnchor.constraint(equalTo: mainAlertView.leadingAnchor, constant: 30),
            confirmBtn.trailingAnchor.constraint(equalTo: mainAlertView.trailingAnchor, constant: -30),
            confirmBtn.heightAnchor.constraint(equalToConstant: 41.5)
        ]

        NSLayoutConstraint.activate(constraintList)
    }
    
    @objc func pressed(_ sender:  UIButton) {
        delegate!.excuteConfirmFunc(sender: sender)
    }
}
