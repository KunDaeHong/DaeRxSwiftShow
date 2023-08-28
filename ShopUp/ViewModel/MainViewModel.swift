//
//  MainViewModel.swift
//  ShopUp
//
//  Created by Daahyeon Hong on 2022/12/15.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MainCarouselViewModel {
    ///carousel
    let carouselListCount = BehaviorRelay<Int>(value: 0)
    let carouselModelList = BehaviorRelay<[MainCarouselModel]>(value: [])
    let carouselUIViewList = BehaviorRelay<[CarouselData]>(value: [])
    
    ///status
    var statusListCount: Int = 0
    let statusModelList = BehaviorRelay<[AllStatusModel]>(value: [])
    
    var scrollToEnd: Bool = false
    var scrollToBegin: Bool = false
    
    private let disposeBag = DisposeBag()
    
    init(data: Data){
        var carouselModel = try! JSONDecoder().decode([MainCarouselModel].self, from: data)
        carouselListCount.accept(carouselModel.count)
        carouselModel.insert(carouselModel.last!, at: 0)
        carouselModel.append(carouselModel[1])
        carouselModelList.accept(carouselModel)
    }
    
    //메인 carousel View에 추가될 리스트들 안에 있는 View 설정
    func appendCarouselListAppend() {
        carouselModelList.subscribe(
            onNext: {
                modelElement in
                var carouselUiViewDataList : [CarouselData] = []
                for modelListElement in modelElement {
                    let elementView: UIView = UIView()
                    carouselUiViewDataList.append(
                        CarouselData(
                            viewData: elementView, title: modelListElement.title, subTitle: modelListElement.subTitle
                    ))
                }
                self.carouselUIViewList.accept(carouselUiViewDataList)
            }
        ).disposed(by: disposeBag)
    }
    
}
