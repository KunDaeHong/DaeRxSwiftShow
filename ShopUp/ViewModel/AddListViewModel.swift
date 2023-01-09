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

class AddListViewModel {
    
    // MARK: Views Infomation Elements
    
    //Food list
    let foodIngredientsList = BehaviorRelay<[FoodInfomationModel]>(value: [])
    
    // Granted permission status
    let cameraPermission = BehaviorRelay<Bool>(value: false)
    let photoLibraryPermission = BehaviorRelay<Bool>(value: false)
    let motionPermission = BehaviorRelay<Bool>(value: false)
    
    let recommandString = BehaviorRelay<String>(value: "추천할 사항이 있다면 그때 말씀드릴게요.")
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: Initializer
    
    init(){}
    
    // MARK: Main Function Listener
    
    public func recommandStringListener() {
        
    }
    
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
    
}
