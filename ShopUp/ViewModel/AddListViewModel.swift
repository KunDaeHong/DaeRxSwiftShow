//
//  AddListViewModel.swift
//  ShopUp
//
//  Created by 파토스 on 2023/01/06.
//

import Foundation
import RxSwift
import RxCocoa
import AVFoundation
import Photos
import CoreMotion

protocol AddListViewModelDelegate: AnyObject{
    func alertPresentToVc(alert: UIAlertController)
}

class AddListViewModel {
    
    // MARK: Delegate
    weak public var delegate: AddListViewModelDelegate?
    
    // MARK: Views Infomation Elements
    
    //Food list
    let foodIngredientsList = BehaviorRelay<[FoodInfomationModel]>(value: [])
    
    // Granted permission status
    let cameraPermission = BehaviorRelay<Bool>(value: false)
    let photoLibraryPermission = BehaviorRelay<Bool>(value: false)
    let motionPermission = BehaviorRelay<Bool>(value: false)
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: Initializer
    
    init(){
        Task{
            self.cameraPermission.accept((await self.chkCameraPermission()))
            self.photoLibraryPermission.accept((await self.chkPhotoLibraryPermission()))
            self.motionPermission.accept((await self.chkMotionPermission()))
        }
    }
    
    // MARK: Permission Check Functions
    
    private func chkCameraPermission() async -> Bool{
        let mediaType = AVMediaType.video
        let mediaAuthoriztionStatus = AVCaptureDevice.authorizationStatus(for: mediaType)
        switch mediaAuthoriztionStatus{
        case .authorized:
            print("@@@@ ShopUp Camera Permission @True")
            return true
        case .denied, .restricted:
            print("@@@@ ShopUp Camera Permission @False")
            self.warningAlert(title: "권한 오류", infoMativeMsg: "카메라 권한을 허용하지 않을 시 휴대폰 내 사진을 이용하여야 합니다.")
            return false
        case .notDetermined :
            return await AVCaptureDevice.requestAccess(for: .video)
        default:
            return false
        }
    }
    
    private func chkPhotoLibraryPermission() async -> Bool {
        let status = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
        switch status {
        case .authorized:
            print("@@@@ ShopUp Photo Permission @True")
            return true
        case .denied:
            print("@@@@ ShopUp Photo Permission @False")
            self.warningAlert(title: "권한 오류", infoMativeMsg: "사진 접근 권한을 허용하지 않을 시 카메라를 이용하여 사진을 분석해야합니다. 카메라, 사진 권한이 허용되지 않으면 기능 작동이 불가합니다.")
            return false
        case .restricted, .notDetermined :
            print("@@@@ ShopUp Photo Permission @False")
            self.warningAlert(title: "권한 오류", infoMativeMsg: "설정 > 개인정보보호 > 사진 에서 권한을 허용해주세요.")
            return false
        default:
            return false
        }
    }
    
    private func chkMotionPermission() async -> Bool{
        let coreMotionGranted = CMPedometer.authorizationStatus()
        switch coreMotionGranted {
        case .authorized:
            print("@@@@ ShopUp CoreMotion Permission @True")
            return true
        case .notDetermined, .restricted :
            print("@@@@ ShopUp Photo Permission @False")
            self.warningAlert(title: "권한 오류", infoMativeMsg: "설정 > 개인정보보호 > 동작 및 피트니스 에서 권한을 허용해주세요.")
            return false
        case .denied :
            self.warningAlert(title: "권한 오류", infoMativeMsg: "휴대폰 움직임 센서 접근 권한이 없으면 분석 사진을 찍을 때 안내 추천을 할 수 없습니다. 사용을 원할 시 설정 > 개인정보보호 > 동작 및 피트니스 에서 권한을 허용해주세요.")
            return false
        default:
            return false
        }
    }
    
    // MARK: Extensions Functions
    
    public func warningAlert(title: String, infoMativeMsg: String, completionHandler: Void? = nil) {
        let alert = UIAlertController(title: title, message: infoMativeMsg, preferredStyle: .alert)
        if completionHandler != nil {
            let okAction = UIAlertAction(title: title, style: .default, handler: {_ in completionHandler})
            alert.addAction(okAction)
        }else {
            let okAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okAction)
        }
    }
    
}
