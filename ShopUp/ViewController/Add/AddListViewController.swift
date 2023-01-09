//
//  AddListViewController.swift
//  ShopUp
//
//  Created by 파토스 on 2023/01/05.
//

import UIKit
import CoreGraphics
import AVFoundation
import CoreMotion
import RxSwift
import RxCocoa

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
    override func viewDidLoad() {
        super.viewDidLoad()
        addListViewModel = AddListViewModel(vc: self)
    }
    
    // MARK: View Configuration Function
    
    private func configurationCameraView() {
        
    }
    
    // MARK: get detect Pixel size or box
    
//    func getPixelColor(pos: CGPoint, image: UIImage) -> UIColor {
//        let pixelData = CGDataProviderCopu
//    }
}
