//
//  AddListViewController.swift
//  ShopUp
//
//  Created by 파토스 on 2023/01/05.
//

import UIKit
import RxSwift
import RxCocoa
import AVFoundation
import Photos

class AddListViewController: UIViewController {
    
    // MARK: Delegate
    
    
    // MARK: Main View
    
    // Show camera preview of main view
    @IBOutlet var cameraView: UIView!
    
    //  Blur App Bar of main view
    @IBOutlet var blurAppBar: UIView!
    
    // MARK: View Model
    
    var addListViewModel: AddListViewModel?
    private let disposeBag = DisposeBag()
    
    // MARK: Life Cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addListViewModel = AddListViewModel()
        configurationCameraView()
        configurationBlurAppBar()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: View Configuration Function
    
    private func configurationCameraView() {
        Task{
            addListViewModel?.cameraPermission.accept(await chkCameraPermission())
            
            if addListViewModel!.cameraPermission.value.self {
                let captureSession = AVCaptureSession()
                guard let captureDevice = AVCaptureDevice.default(for: .video),
                      let input = try? AVCaptureDeviceInput(device: captureDevice) else {return}
                
                captureSession.addInput(input)
                captureSession.startRunning()
                
                let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer.frame = cameraView.frame
                previewLayer.videoGravity = .resizeAspectFill
                cameraView.layer.insertSublayer(previewLayer, at: 0)
            }
        }
    }
    
    private func configurationBlurAppBar() {
        blurAppBar.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = blurAppBar.frame
        blurAppBar.insertSubview(visualEffectView, at: 0)
    }
    
    // MARK: get detect Pixel size or box
    
//    func getPixelColor(pos: CGPoint, image: UIImage) -> UIColor {
//        let pixelData = CGDataProviderCopu
//    }
    
    // MARK: Permission Check Functions
    
    private func chkCameraPermission() async -> Bool{
        let mediaType = AVMediaType.video
        await AVCaptureDevice.requestAccess(for: mediaType)
        let mediaAuthoriztionStatus = AVCaptureDevice.authorizationStatus(for: mediaType)
        switch mediaAuthoriztionStatus{
        case .authorized:
            print("@@@@ ShopUp Camera Permission @True")
            return true
        case .denied, .restricted, .notDetermined:
            print("@@@@ ShopUp Camera Permission @False")
                self.warningAlert(title: "권한 오류", infoMativeMsg: "카메라 권한을 허용하지 않을 시 휴대폰 내 사진을 이용하여야 합니다.")
            return false
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
        case .denied, .restricted, .notDetermined:
            print("@@@@ ShopUp Photo Permission @False")
            DispatchQueue.main.async {
                self.warningAlert(title: "권한 오류", infoMativeMsg: "사진 접근 권한을 허용하지 않을 시 카메라를 이용하여 사진을 분석해야합니다. 카메라, 사진 권한이 허용되지 않으면 기능 작동이 불가합니다. 사용을 원할 시 설정 > 개인정보보호 > 사진 에서 권한을 허용해주세요.")
            }
            return false
        default:
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
