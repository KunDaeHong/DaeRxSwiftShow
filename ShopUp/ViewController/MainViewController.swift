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
    
    
    ///MainViewCtrl Main Views
    
    //mainPages Top Nav Buttons View
    @IBOutlet weak var mainPagesButtonsUiView: UIView!
    
    //carousel
    @IBOutlet weak var scrollMainView: UIView!
    @IBOutlet weak var mainCarouselUiView: UICollectionView!
    @IBOutlet weak var mainCarouselPageCtrlUiView: UIView!
    private let collectionViewFlowLayout = UICollectionViewFlowLayout()
    
    //recommand data view
    @IBOutlet weak var recomandView: UIView!
    
    
    
    
    
    /// etc small Widgets for View

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
    
    
    ///ViewModel
    var mainViewModel: MainCarouselViewModel?
    private let disposeBag = DisposeBag()

    
    ///Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewModel = MainCarouselViewModel(data: getJsonDataFromFile())
        mainCarouselViewSettings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureRecomandView()
    }
    
    
    ///Get Data Function
    // json 파일을 레퍼런스 데이터에서 직접 들고옴. (리턴타입: Data)
    private func getJsonDataFromFile() -> Data{
        if let path = Bundle.main.path(forResource: "shopUpMainCarousel_dataSources", ofType: "json"){
            return try! Data(contentsOf: URL(fileURLWithPath: path))
        }else {
            fatalError("Invaild Read File. Check File format or exist in Reference.")
        }
    }
    
    ///View Configuration Function
    
    
    private func mainCarouselViewSettings() {
        mainCarouselUiView.register(CarouselUICell.self, forCellWithReuseIdentifier: CarouselUICell.description())
        mainCarouselPageCtrlViewSettings()
        mainViewModel!.appendCarouselListAppend()
        configureCarouselView()
    }
    
    private func mainCarouselPageCtrlViewSettings() {
        mainCarouselPageCtrlUiView.addSubview(pageCtrl)
        pageCtrl.numberOfPages = (mainViewModel?.carouselListCount)!
        pageCtrl.backgroundColor = .clear
        pageCtrl.translatesAutoresizingMaskIntoConstraints = false
        let pageCtrlConstraint = [
            pageCtrl.widthAnchor.constraint(equalToConstant: 150),
            pageCtrl.heightAnchor.constraint(equalToConstant: 30),
            pageCtrl.centerYAnchor.constraint(equalTo: mainCarouselPageCtrlUiView.centerYAnchor),
            pageCtrl.centerXAnchor.constraint(equalTo: mainCarouselPageCtrlUiView.centerXAnchor),
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
    
    private func configureRecomandView() {
        recomandView.addSubview(
            todaysRecommandPickView(
                frame: recomandView.bounds,
                nothing: false,
                warning: false,
                good: true,
                bad: false))
        recomandView.backgroundColor = .clear
    }
    
    ///widgets
    func todaysRecommandPickView(frame: CGRect, nothing: Bool, warning: Bool, good: Bool, bad: Bool) -> UIView{
        let mainView : UIView = UIView(frame: frame)
        
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 41.5
        if(nothing){
            mainView.setTwoGradientUIView(
                firstColor: AppColorType.grayGradientFirstColor.rawValue,
                secondColor: AppColorType.grayGradientSecondColor.rawValue,
                firstPosition: .LeftB,
                secondPosition: .rightT)
        }else if (warning){
            mainView.setTwoGradientUIView(
                firstColor: AppColorType.orangeGradientFirstColor.rawValue,
                secondColor: AppColorType.orangeGradientSecondColor.rawValue,
                firstPosition: .LeftB,
                secondPosition: .rightT)
        }else if(bad){
            mainView.setTwoGradientUIView(
                firstColor: AppColorType.redGradientFirstColor.rawValue,
                secondColor: AppColorType.redGradientSecondColor.rawValue,
                firstPosition: .LeftB,
                secondPosition: .rightT)
        }else if(good){
            mainView.setTwoGradientUIView(
                firstColor: AppColorType.greenGradientFirstColor.rawValue,
                secondColor: AppColorType.greenGradientSecondColor.rawValue,
                firstPosition: .LeftB,
                secondPosition: .rightT)
        }
        
        
        let title = UILabel()
        let subTitle = UILabel()
        let confirmBtn = SmallConfirmButton(
            title: nothing == true ? "추가" : "확인", font: .systemFont(ofSize: 13, weight: .regular), color: .blackFontColor)
        
        if(nothing){title.text = "등록 리스트가 없네요?!"}
        else if(warning){title.text = "기한이 끝나가는 음식이 있어요."}
        else if(bad){title.text = "기한이 끝난 음식입니다.."}
        else if(good){title.text = "오늘은 OOO가 어떨까요?"}
        
        title.textColor = AppColorType.whiteFontColor.rawValue
        title.font = .systemFont(ofSize: 23, weight: .heavy)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.lineBreakMode = .byTruncatingTail
        title.numberOfLines = 0
        title.sizeToFit()
        
        if(nothing){subTitle.text = "구매내역을 추가하여 더욱 확실하게 내역을 확인하고 추천을 받아보세요!\n더 나은 생활, 저희가 책임질게요."}
        else if(warning){subTitle.text = "OOO 음식의 기한이 거의 다 되어가요.\n소비기한이 지나가기전에 한번쯤 냉장고를 확인해보는게 좋을 것 같아요."}
        else if(bad){subTitle.text = "OOO 음식은 이미 기한을 지나버렸어요...\n아깝지만 건강과 깨끗한 지구 환경을 위해 노력해봐요!"}
        else if(good){subTitle.text = "이 음식으로 만들 수 있는 것이\n무엇이 있을지 인터넷에 찾아보는건 어떨까요?\n여러분의 음식을 항상 지켜줄게요."}
        subTitle.textColor = AppColorType.whiteColor.rawValue
        subTitle.font = .systemFont(ofSize: 15, weight: .regular)
        subTitle.lineBreakMode = .byTruncatingTail
        subTitle.textAlignment = .natural
        subTitle.numberOfLines = 0
        subTitle.sizeToFit()
        subTitle.translatesAutoresizingMaskIntoConstraints = false

        mainView.addSubview(title)
        mainView.addSubview(subTitle)
        mainView.addSubview(confirmBtn)
        
        let constraintList = [
            title.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            title.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 25),
            title.trailingAnchor.constraint(lessThanOrEqualTo: mainView.trailingAnchor),
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            subTitle.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            subTitle.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -70),
            confirmBtn.widthAnchor.constraint(equalToConstant: confirmBtn.frame.size.width),
            confirmBtn.heightAnchor.constraint(equalToConstant: confirmBtn.frame.size.height),
            confirmBtn.leadingAnchor.constraint(greaterThanOrEqualTo: mainView.leadingAnchor),
            confirmBtn.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -30),
            confirmBtn.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -25),
        ]
        NSLayoutConstraint.activate(constraintList)
        return mainView
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
