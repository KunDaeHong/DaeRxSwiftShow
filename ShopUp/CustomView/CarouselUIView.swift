//
//  CarouselUIView.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2022/12/15.
//

import Foundation
import UIKit

class CarouselUiView: UIView {
    
    private lazy var carousel: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = self
        collection.backgroundColor = .clear
        return collection
    }()
    
    private lazy var pageController: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .white
        return pageControl
    }()
    
    private var carouselData = [CarouselData]()
    private var currentIdx = 0
}

struct CarouselData {
    let viewData: UIView?
    let title: String
    let subTitle: String
}

extension CarouselUiView {
    public func configureView(with data: [CarouselData]){
        //let cellPadding = (frame.width - 300) / 2
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: 300, height: 400)
        carouselLayout.sectionInset = .zero
        carousel.collectionViewLayout = carouselLayout
        carouselData = data
        carousel.reloadData()
    }
}

extension CarouselUiView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselUICell.cellId, for: indexPath) as? CarouselUICell else {
            return UICollectionViewCell()
        }
        
        let viewData = carouselData[indexPath.row].viewData
        let title = carouselData[indexPath.row].title
        let subTitle = carouselData[indexPath.row].subTitle
        
        cell.configure(view: viewData!, title: title, subTitle: subTitle)
        
        return cell
    }
}
