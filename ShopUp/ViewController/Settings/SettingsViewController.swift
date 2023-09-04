//
//  SettingsViewController.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2022/12/26.
//

import UIKit
import RxCocoa
import RxSwift

class SettingsViewController: UIViewController {

    // MARK: SettingsViewController Main Views
    
    //easy Settings view
    @IBOutlet weak var easySettingsCollectionView: UICollectionView!
    private let easySettingsCollectionFlowLayout = UICollectionViewFlowLayout()
    
    //list Settings view
    @IBOutlet weak var listSettingsCollectionView: UICollectionView!
    private let listSettingsCollectionFlowLayout = UICollectionViewFlowLayout()
    
    private let disposeBag = DisposeBag()
    private var settingsViewModel: SettingsViewModel?
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        settingsViewModel = SettingsViewModel()
        configureEasySettingsView()
        configureListSettingsView()
    }
    
    
    // MARK: View action
    
    //Back Navigation
    @IBAction func GoingToBack(_ sender: Any) {
        if let navCtrl = self.navigationController {
            navCtrl.popViewController(animated: true)
        }
    }
    
    @IBAction func sendBug(_ sender: Any) {
        //SettingsService.sendMail(json: ["": ""], vc: SettingsViewController())
        DispatchQueue.main.async {
            let alertMgr = WarningAlert(title: "에러", description: "테스트", confirmBtn: true)
            alertMgr.frame = self.view.frame
            self.view.addSubview(alertMgr)
        }
    }
    
    
    // MARK: View Configuration Function
    
    private func configureEasySettingsView() {
        easySettingsCollectionView.register(SmallFitCollectionCell.self, forCellWithReuseIdentifier: SmallFitCollectionCell.description())
        easySettingsCollectionView.dataSource = self
        easySettingsCollectionView.delegate = self
        easySettingsCollectionFlowLayout.scrollDirection = .horizontal
        easySettingsCollectionFlowLayout.itemSize = .init(width: 120, height: easySettingsCollectionView.frame.height - 10)
        easySettingsCollectionFlowLayout.minimumLineSpacing = 25
        easySettingsCollectionFlowLayout.sectionInset = .init(top: 0, left: 25, bottom: 0, right: 25)
        easySettingsCollectionView.collectionViewLayout = easySettingsCollectionFlowLayout
    }
    
    private func configureListSettingsView() {
        listSettingsCollectionView.register(CollectionListCell.self, forCellWithReuseIdentifier: CollectionListCell.description())
        listSettingsCollectionView.dataSource = self
        listSettingsCollectionView.delegate = self
        listSettingsCollectionFlowLayout.scrollDirection = .vertical
        listSettingsCollectionFlowLayout.itemSize = .init(width: listSettingsCollectionView.bounds.size.width, height: 50)
        listSettingsCollectionFlowLayout.minimumLineSpacing = 0
        listSettingsCollectionFlowLayout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        listSettingsCollectionView.collectionViewLayout = listSettingsCollectionFlowLayout
    }
}

extension SettingsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == easySettingsCollectionView {
            return settingsViewModel!.easySettingsList.value.count
        }else if collectionView == listSettingsCollectionView {
            return settingsViewModel!.settingsList.count
        }else {
            return 1
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == easySettingsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallFitCollectionCell.description(), for: indexPath) as? SmallFitCollectionCell else {
                return UICollectionViewCell()
            }
            
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large)
            
            
            settingsViewModel!.easySettingsList.bind(onNext: {
                element in
                
                cell.configure(
                    title: element[indexPath.row].title,
                    firstColor: element[indexPath.row].firstColor,
                    secondColor: element[indexPath.row].secondColor,
                    gradientFirstDirection: .LeftB,
                    gradientSecondDirection: .rightT,
                    image: element[indexPath.row].image ?? UIImage(systemName: "gearshape.fill", withConfiguration: largeConfig)
                )
            }).disposed(by: disposeBag)
            
            return cell
        }else if collectionView == listSettingsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionListCell.description(), for: indexPath) as? CollectionListCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(
                title: settingsViewModel!.settingsList[indexPath.row],
                indexPath: indexPath,
                lastIndex: settingsViewModel!.settingsList.count,
                border: true,
                borderWidth: 1,
                completionHandler: {
                    let sb: UIStoryboard = UIStoryboard(name: "Settings", bundle: nil)
                    let vc = sb.instantiateViewController(withIdentifier: "SettingsInsideVC") as! SettingsInsideViewController
                    vc.titleString = self.settingsViewModel!.settingsList[indexPath.row]
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            )
            
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
}

extension SettingsViewController: UICollectionViewDelegate {
    
}
