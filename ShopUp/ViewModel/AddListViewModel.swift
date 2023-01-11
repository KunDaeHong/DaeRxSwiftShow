//
//  AddListViewModel.swift
//  ShopUp
//
//  Created by 파토스 on 2023/01/06.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import CoreMotion

class AddListViewModel {
    
    // MARK: Views Infomation Elements
    
    //Food list
    let foodIngredientsList = BehaviorRelay<[FoodInfomationModel]>(value: [])
    
    // Granted permission status
    let cameraPermission = BehaviorRelay<Bool>(value: false)
    let photoLibraryPermission = BehaviorRelay<Bool>(value: false)
    let motionPermission = BehaviorRelay<Bool>(value: false)
    
    private let recommandStringBehaviorRelay: BehaviorRelay<String> = BehaviorRelay<String>(value: "추천할 사항이 있다면 그때 말씀드릴게요.")
    
    var recommandString: Observable<String>{
        return recommandStringBehaviorRelay.asObservable()
    }
    
    private let disposeBag = DisposeBag()
    
    //CoreMotion Manager
    let motionManager = CMMotionManager()
    var detectShakeTimer: Timer?
    
    var currentAverageRotation: Double = 0.0
    
    
    // MARK: Initializer
    
    init(){}
    
    // MARK: Main Function Listener
    
    public func recommandStringListener() {
        if motionPermission.value.self {
            motionManager.gyroUpdateInterval = 0.5
            
            motionManager.startGyroUpdates(
                to: OperationQueue.current!, withHandler: {
                    (gyroData: CMGyroData!, error: Error!) -> Void in
                    self.outputRotationData(gyroData.rotationRate)
                    if error != nil {
                        print("GYRO Data Error or Check Function")
                    }
            })
        }
        
        if detectShakeTimer == nil {
            let timerInterval: Double = 1.0
            detectShakeTimer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true){
                [weak self] (Timer) in
                if(self!.currentAverageRotation > 0.5){
                    self!.recommandStringBehaviorRelay.accept(("카메라를 조금 더 고정해주세요."))
                }else {
                    self!.recommandStringBehaviorRelay.accept(("아주 좋아요! 이대로 찍어도 될 것 같아요."))
                }
//                else if
//                RunLoop.current.add(self!.detectShakeTimer!, forMode: .common)
            }
        }
    }
    
    private func outputRotationData(_ rotation: CMRotationRate){
        let averageRotation = sqrt(fabs(rotation.x)) + sqrt(fabs(rotation.y)) + sqrt(fabs(rotation.z))
        
        if currentAverageRotation != averageRotation {
            currentAverageRotation = sqrt(averageRotation) - 0.3
            print("@@@@ average Rotation \(currentAverageRotation)")
        }else {
            print("@@@@ average Rotation \(0.0)")
        }
    }
    
    
    // MARK: Extension Main Functions
    
    public func getImageMainColor(image: UIImage) -> UIColor? {
        guard let ciImage = CIImage(image: image) else {
            return UIColor(rgb: "000000")
        }
        let extentVector = CIVector(x: ciImage.extent.origin.x, y: ciImage.extent.origin.y, z: ciImage.extent.size.width, w: ciImage.extent.size.height)
        
        guard let imageFilter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: ciImage, kCIInputExtentKey: extentVector]) else {
            return nil
        }
        guard let outputImage = imageFilter.outputImage else {return nil}
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(
            outputImage,
            toBitmap: &bitmap,
            rowBytes: 4,
            bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
            format: .RGBA8,
            colorSpace: nil)
        
        return UIColor(red: CGFloat(bitmap[0])/255, green: CGFloat(bitmap[1])/255, blue: CGFloat(bitmap[2])/255, alpha: CGFloat(bitmap[3]) / 255)
    }
    
    public func getPercentDark(image: UIImage) -> Int{
        guard let imageMainColor: UIColor = getImageMainColor(image: image) else {
            return 0
        }
        
        let redColor = imageMainColor.ciColor.red
        let greenColor = imageMainColor.ciColor.green
        let blueColor = imageMainColor.ciColor.blue
        
        let percentDarker: Int = Int((redColor + greenColor + blueColor)) / 255 * 100
        
        return percentDarker
    }
    
}
