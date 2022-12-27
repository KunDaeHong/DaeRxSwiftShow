//
//  MainViewModel.swift
//  ShopUp
//
//  Created by Daahyeon Hong on 2022/12/15.
//

import Foundation
import RxSwift
import RxCocoa

class MainCarouselViewModel {
    ///carousel
    let carouselListCount: Int!
    let carouselModelList: Observable<[MainCarouselModel]>!
    let carouselUIViewList = BehaviorRelay<[CarouselData]>(value: [])
    
    ///status
    var statusListCount: Int = 0
    let statusModelList = BehaviorRelay<[AllStatusModel]>(value: [])
    
    var scrollToEnd: Bool = false
    var scrollToBegin: Bool = false
    
    private let disposeBag = DisposeBag()
    
    init(data: Data){
        let carouselModel = try! JSONDecoder().decode([MainCarouselModel].self, from: data)
        carouselListCount = carouselModel.count
        carouselModelList = Observable<[MainCarouselModel]>.just(carouselModel)
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
