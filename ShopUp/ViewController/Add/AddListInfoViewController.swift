//
//  AddListInfoViewController.swift
//  ShopUp
//
//  Created by 파토스 on 2023/01/06.
//

import UIKit
import RxSwift
import RxCocoa
import CoreMotion

class AddListInfoViewController: UIViewController {
    // MARK: Main Views
    
    @IBOutlet weak var recommandString: UILabel!
    
    // MARK: View Model
    
    var addListViewModel: AddListViewModel?
    private let disposeBag = DisposeBag()
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addListViewModel = AddListViewModel()
        
        Task{
            addListViewModel?.motionPermission.accept(await chkMotionPermission())
            addListViewModel!.recommandStringListener()
            configurationRecommandString()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        addListViewModel?.motionManager.stopAccelerometerUpdates()
        addListViewModel?.motionManager.stopGyroUpdates()
        addListViewModel?.detectShakeTimer?.invalidate()
        addListViewModel?.detectShakeTimer = nil
    }
    
    // MARK: View Configuration Fucntion
    
    private func configurationRecommandString(){
        addListViewModel?.recommandString.subscribe(onNext: {
            [weak self] title in
            self!.recommandString.text = title
        }).disposed(by: disposeBag)
    }
    
    // MARK: Permission Check Functions
    
    private func chkMotionPermission() async -> Bool{
        if CMPedometer.isStepCountingAvailable(){
            let pedoMeter = CMPedometer()
            pedoMeter.startUpdates(from: Date()) {
                (data, error) in
                if error == nil {
                    pedoMeter.stopUpdates()
                }
            }
            let coreMotionGranted = CMPedometer.authorizationStatus()
            switch coreMotionGranted {
            case .authorized:
                print("@@@@ ShopUp CoreMotion Permission @True")
                return true
            case .notDetermined, .restricted, .denied :
                print("@@@@ ShopUp CoreMotion Permission @False")
                DispatchQueue.main.async {
                    self.warningAlert(title: "권한 오류", infoMativeMsg: "휴대폰 움직임 센서 접근 권한이 없으면 분석 사진을 찍을 때 안내 추천을 할 수 없습니다. 사용을 원할 시 설정 > 개인정보보호 > 동작 및 피트니스 에서 권한을 허용해주세요.")
                }
                return false
            default:
                return false
            }
        }else {
            return false
        }
    }
    
    
    // MARK: Extensions Functions
    
    func warningAlert(title: String, infoMativeMsg: String, completionHandler: Void? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: infoMativeMsg, preferredStyle: .alert)
            if completionHandler != nil {
                let okAction = UIAlertAction(title: "확인", style: .default, handler: {_ in completionHandler})
                alert.addAction(okAction)
            }else {
                let okAction = UIAlertAction(title: "확인", style: .default)
                alert.addAction(okAction)
            }
            self.present(alert, animated: true, completion: completionHandler != nil ? {completionHandler!} : nil)
        }
    }
}
