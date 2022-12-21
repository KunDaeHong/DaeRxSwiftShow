//
//  MainViewController.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2022/12/15.
//

import UIKit
import RxCocoa
import RxSwift

class MainViewController: UIViewController {
    
    ///View
    //carousel
    @IBOutlet weak var scrollMainView: UIView!
    @IBOutlet weak var mainCarouselUiView: UICollectionView!
    @IBOutlet weak var mainCarouselPageCtrlUiView: UIView!
    private let collectionViewFlowLayout = UICollectionViewFlowLayout()
    //addDataView
    @IBOutlet weak var mainAddUserView: UIView!
    private let addUserInfoView: UIView = {
        let uiView = UIView()
        uiView.clipsToBounds = false
        uiView.layer.cornerRadius = 41.5
        return uiView
    }()
    
    /// data for View
    //carousel
    private lazy var pageCtrl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .white
        return pageControl
    }()
    private var currentPage = 0 {
        didSet {
            pageCtrl.currentPage = currentPage
        }
    }
    
    var mainViewModel: MainCarouselViewModel?
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewModel = MainCarouselViewModel(data: getJsonDataFromFile())
        mainCarouselViewSettings()
    }
    
    // json 파일을 레퍼런스 데이터에서 직접 들고옴. (리턴타입: Data)
    private func getJsonDataFromFile() -> Data{
        if let path = Bundle.main.path(forResource: "shopUpMainCarousel_dataSources", ofType: "json"){
            return try! Data(contentsOf: URL(fileURLWithPath: path))
        }else {
            fatalError("Invaild Read File. Check File format or exist in Reference.")
        }
    }
    
    ///메인 carousel View 설정
    private func mainCarouselViewSettings() {
        mainCarouselUiView.register(CarouselUICell.self, forCellWithReuseIdentifier: CarouselUICell.description())
        mainCarouselPageCtrlViewSettings()
        mainViewModel!.appendCarouselListAppend()
        configureCarouselView()
        configureUserInfomationView()
    }
    
    private func mainCarouselPageCtrlViewSettings() {
        mainCarouselPageCtrlUiView.addSubview(pageCtrl)
        pageCtrl.numberOfPages = (mainViewModel?.carouselListCount)!
        pageCtrl.backgroundColor = .clear
        pageCtrl.translatesAutoresizingMaskIntoConstraints = false
        let pageCtrlConstraint = [
            pageCtrl.widthAnchor.constraint(equalToConstant: 150),
            pageCtrl.heightAnchor.constraint(equalToConstant: 30),
        ]
        NSLayoutConstraint.activate(pageCtrlConstraint)
    }
    
    private func configureCarouselView(){
        mainCarouselUiView.dataSource = self
        mainCarouselUiView.delegate = self
        mainCarouselUiView.isPagingEnabled = true
        collectionViewFlowLayout.scrollDirection = .horizontal
        let cellPadding = (mainCarouselUiView.bounds.width - 280) / 2
        collectionViewFlowLayout.itemSize = .init(width: 300, height: 400)
        collectionViewFlowLayout.sectionInset = .init(top: 0, left: cellPadding, bottom: 0, right: cellPadding)
        collectionViewFlowLayout.minimumLineSpacing = cellPadding * 2
        mainCarouselUiView.collectionViewLayout = collectionViewFlowLayout
    }
    
    private func getCarouselCurrentPage() -> Int {
        let visibleRect = CGRect(origin: mainCarouselUiView.contentOffset, size: mainCarouselUiView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = mainCarouselUiView.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }
        return currentPage
    }
    
    ///메인 2nd menu
    private func configureUserInfomationView() {
        let title: UILabel = UILabel()
        mainAddUserView.addSubview(title)
        title.text = "내가 너라면"
        title.font = .boldSystemFont(ofSize: 20)
        title.textColor = .black
        title.sizeToFit()
        title.translatesAutoresizingMaskIntoConstraints = false
        //시각차이로 인해 제목보다 아래 사각형이 더 크게 제작되었음.
        mainAddUserView.addSubview(addUserInfoView)
        addUserInfoView.translatesAutoresizingMaskIntoConstraints = false
        addUserInfoView.backgroundColor = UIColor(rgb: "b6b6b6").withAlphaComponent(0.5)
        
        let everythisConstraint = [
            //titleView
            title.leadingAnchor.constraint(equalTo: mainAddUserView.leadingAnchor, constant: 30),
            title.trailingAnchor.constraint(equalTo: mainAddUserView.trailingAnchor, constant: -30),
            title.topAnchor.constraint(equalTo: mainAddUserView.topAnchor, constant: 0),
            //addUserInfoView
            addUserInfoView.trailingAnchor.constraint(equalTo: title.trailingAnchor, constant: +10),
            addUserInfoView.leadingAnchor.constraint(equalTo: title.leadingAnchor, constant: -10),
            addUserInfoView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            addUserInfoView.bottomAnchor.constraint(equalTo: mainAddUserView.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(everythisConstraint)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (mainViewModel?.carouselListCount)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselUICell.description(), for: indexPath) as? CarouselUICell else {
            return UICollectionViewCell()
        }
        
        let viewData = mainViewModel?.carouselUIViewList.value[indexPath.row].viewData
        let title = mainViewModel?.carouselUIViewList.value[indexPath.row].title
        let subTitle = mainViewModel?.carouselUIViewList.value[indexPath.row].subTitle
        
        
        cell.setTwoGradientUICollectionCell(
            firstColor: UIColor(rgb: "f56056"),
            secondColor: UIColor(rgb: "ffa9a3"),
            firstPosition: .LeftB,
            secondPosition: .rightT)
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 41.5
        
        cell.configure(view: viewData!, title: title!, subTitle: subTitle!)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let endOffset = scrollView.contentSize.width - mainCarouselUiView.frame.width
        
        if scrollView.contentOffset.x < .zero && velocity.x < .zero {
            mainViewModel?.scrollToEnd = true
           
        } else if scrollView.contentOffset.x > endOffset && velocity.x > .zero {
            mainViewModel?.scrollToBegin = true
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if (mainViewModel?.scrollToEnd)! {
            mainViewModel?.scrollToEnd.toggle()
            mainCarouselUiView.scrollToItem(at: IndexPath(row: (mainViewModel?.carouselListCount)! - 1, section: .zero), at: .centeredHorizontally, animated: true)
        } else if (mainViewModel?.scrollToBegin)! {
            mainViewModel?.scrollToBegin.toggle()
            mainCarouselUiView.scrollToItem(at: IndexPath(row: .zero, section: .zero), at: .centeredHorizontally, animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCarouselCurrentPage()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        currentPage = getCarouselCurrentPage()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = getCarouselCurrentPage()
    }
}
