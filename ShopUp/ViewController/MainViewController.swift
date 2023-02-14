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
    
    
    // MARK: MainViewCtrl Main Views
    
    //main Scroll View
    @IBOutlet weak var scrollView: UIScrollView!
    
    //mainPages Top Nav Buttons View
    @IBOutlet weak var mainPagesButtonsUiView: UIView!
    
    //carousel
    @IBOutlet weak var scrollMainView: UIView!
    @IBOutlet weak var mainCarouselUiView: UICollectionView!
    @IBOutlet weak var mainCarouselPageCtrlUiView: UIView!
    private let collectionViewFlowLayout = UICollectionViewFlowLayout()
    
    //recommand data view
    @IBOutlet weak var recomandView: UIView!
    
    //ad view
    @IBOutlet weak var adView: UIView!{
        didSet{
            self.adView.backgroundColor = .clear
            self.adView.clipsToBounds = true
            self.adView.layer.cornerRadius = 41.5
            self.adView.layer.borderWidth = 2
            self.adView.layer.borderColor = AppColorType.grayGradientFirstColor.rawValue.cgColor
        }
    }
    
    //now Status view
    @IBOutlet weak var nowStatusCollectionView: UICollectionView!
    private let nowStatusCollectionFlowLayout = UICollectionViewFlowLayout()
    
    
    // MARK: View Models
    
    var mainViewModel: MainCarouselViewModel?
    private let disposeBag = DisposeBag()
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        scrollView.delegate = self
        mainViewModel = MainCarouselViewModel(data: getJsonDataFromFile())
        mainCarouselViewSettings()
        configureNowStatusView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureRecomandView()
        mainCarouselUiView.scrollToItem(at: IndexPath(row: 1, section: .zero), at: .centeredHorizontally, animated: false)
        mainCarouselUiView.setContentOffset(mainCarouselUiView.contentOffset, animated: false)
        currentPage = 0
    }
    
    
    // MARK: Get Data Function
    
    // json 파일을 레퍼런스 데이터에서 직접 들고옴. (리턴타입: Data)
    private func getJsonDataFromFile() -> Data{
        if let path = Bundle.main.path(forResource: "shopUpMainCarousel_dataSources", ofType: "json"){
            return try! Data(contentsOf: URL(fileURLWithPath: path))
        }else {
            fatalError("Invaild Read File. Check File format or exist in Reference.")
        }
    }
    
    // MARK: View action
    
    @IBAction func mainToSettings(_ sender: Any) {
    }
    
    
    // MARK: View Configuration Function
    
    private func mainCarouselViewSettings() {
        mainCarouselUiView.register(CarouselUICell.self, forCellWithReuseIdentifier: CarouselUICell.description())
        mainCarouselPageCtrlViewSettings()
        mainViewModel!.appendCarouselListAppend()
        configureCarouselView()
    }
    
    private func mainCarouselPageCtrlViewSettings() {
        mainCarouselPageCtrlUiView.addSubview(pageCtrl)
        pageCtrl.numberOfPages = (mainViewModel?.carouselListCount)!.value
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
        let cellPadding = (mainCarouselUiView.frame.width - 60)/9
        collectionViewFlowLayout.itemSize = .init(width: mainCarouselUiView.frame.width - 60, height: 400)
        collectionViewFlowLayout.sectionInset = .init(top: 0, left: cellPadding, bottom: 0, right: cellPadding)
        collectionViewFlowLayout.minimumLineSpacing = (mainCarouselUiView.frame.width - 60)/4
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
    
    private func configureNowStatusView() {
        nowStatusCollectionView.register(SmallFitCollectionCell.self, forCellWithReuseIdentifier: SmallFitCollectionCell.description())
        nowStatusCollectionView.dataSource = self
        nowStatusCollectionView.delegate = self
        nowStatusCollectionFlowLayout.scrollDirection = .horizontal
        nowStatusCollectionFlowLayout.itemSize = .init(width: 120, height: nowStatusCollectionView.frame.height - 10)
        nowStatusCollectionFlowLayout.minimumLineSpacing = 25
        nowStatusCollectionFlowLayout.sectionInset = .init(top: 0, left: 25, bottom: 0, right: 25)
        nowStatusCollectionView.collectionViewLayout = nowStatusCollectionFlowLayout
        
        let leftSideOpacityBar = UIView()
        let rightSideOpacityBar = UIView()
        nowStatusCollectionView.addSubview(leftSideOpacityBar)
        nowStatusCollectionView.addSubview(rightSideOpacityBar)
        leftSideOpacityBar.translatesAutoresizingMaskIntoConstraints = false
        rightSideOpacityBar.translatesAutoresizingMaskIntoConstraints = false
        leftSideOpacityBar.setTwoGradientUIView(firstColor: .white, secondColor: .clear, firstPosition: .Left, secondPosition: .right)
        rightSideOpacityBar.setTwoGradientUIView(firstColor: .clear, secondColor: .white, firstPosition: .Left, secondPosition: .right)
        
        let constraintList : [NSLayoutConstraint] = [
            leftSideOpacityBar.widthAnchor.constraint(equalToConstant: 30),
            leftSideOpacityBar.heightAnchor.constraint(equalTo: nowStatusCollectionView.heightAnchor),
            leftSideOpacityBar.leadingAnchor.constraint(equalTo: nowStatusCollectionView.leadingAnchor, constant: 0),
            leftSideOpacityBar.centerYAnchor.constraint(equalTo: nowStatusCollectionView.centerYAnchor),
            rightSideOpacityBar.widthAnchor.constraint(equalToConstant: 30),
            rightSideOpacityBar.heightAnchor.constraint(equalTo: nowStatusCollectionView.heightAnchor),
            rightSideOpacityBar.trailingAnchor.constraint(equalTo: nowStatusCollectionView.trailingAnchor, constant: 0),
            rightSideOpacityBar.centerYAnchor.constraint(equalTo: nowStatusCollectionView.centerYAnchor),
        ]
        
        NSLayoutConstraint.activate(constraintList)
    }
    
    
    // MARK: Widgets
    
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

extension MainViewController: UIScrollViewDelegate {
}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainCarouselUiView {
            var listCount = 0
            mainViewModel!.carouselModelList.subscribe(onNext: {
                count in
                listCount = count.count
            }).disposed(by: disposeBag)
            return listCount
        }else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainCarouselUiView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselUICell.description(), for: indexPath) as? CarouselUICell else {
                return UICollectionViewCell()
            }
            
            let viewData = mainViewModel?.carouselUIViewList.value[indexPath.row].viewData
            let title = mainViewModel?.carouselUIViewList.value[indexPath.row].title
            let subTitle = mainViewModel?.carouselUIViewList.value[indexPath.row].subTitle
            
            cell.configure(view: viewData!, title: title!, subTitle: subTitle!)
            return cell
        }else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallFitCollectionCell.description(), for: indexPath) as? SmallFitCollectionCell else {
                return UICollectionViewCell()
            }
            cell.configure(
                title: "테스트",
                firstColor: .orangeGradientFirstColor,
                secondColor: .orangeGradientSecondColor,
                gradientFirstDirection: .LeftB,
                gradientSecondDirection: .rightT,
                PercentTage: 76)
            return cell
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let endOffset = scrollView.contentSize.width - mainCarouselUiView.bounds.width
        
        if scrollView.contentOffset.x == 0 {
            self.mainCarouselUiView.scrollToItem(at: IndexPath(row: self.mainViewModel!.carouselListCount.value, section: .zero), at: .centeredHorizontally, animated: false)
            self.currentPage = self.mainViewModel!.carouselListCount.value
        } else if endOffset - scrollView.contentOffset.x < 15  {
            self.mainCarouselUiView.scrollToItem(at: IndexPath(row: 1, section: .zero), at: .centeredHorizontally, animated: false)
            self.currentPage = 0
        }else {
            currentPage = getCarouselCurrentPage() - 1
        }
    }
}
