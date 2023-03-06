//
//  SettingsInsideViewController.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2023/01/26.
//

import UIKit
import RxCocoa
import RxSwift

class SettingsInsideViewController: UIViewController {
    
    // MARK: SettingsInsideViewController Main Views
    
    @IBOutlet weak var mainTitle: UILabel!
    
    //list Settings view
    @IBOutlet weak var settingsInsideCollectionView: UICollectionView!
    private let settingsCollectionFlowLayout = UICollectionViewFlowLayout()
    
    // MARK: Views Data
    var titleString : String = ""
    var dataModel: SettingsCellStuffModel?
    
    private let disposeBag = DisposeBag()
    private var settingsViewModel: SettingsViewModel?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationView()
    }
    
    // MARK: View action
    
    @IBAction func backBtn(_ sender: Any) {
        if let navCtrl = self.navigationController {
            navCtrl.popViewController(animated: true)
        }
    }
    
    
    // MARK: View Configuration Function
    private func configurationView() {
        mainTitle.text = titleString
        settingsViewModel = SettingsViewModel()
        configurationCollectionView()
    }
    
    private func configurationCollectionView() {
        settingsInsideCollectionView.register(SettingsCellCollectionViewCell.self, forCellWithReuseIdentifier: SettingsCellCollectionViewCell.description())
        settingsInsideCollectionView.dataSource = self
        settingsCollectionFlowLayout.scrollDirection = .vertical
        settingsCollectionFlowLayout.itemSize = .init(width: settingsInsideCollectionView.bounds.size.width, height: 50)
        settingsCollectionFlowLayout.minimumLineSpacing = 0
        settingsCollectionFlowLayout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        settingsInsideCollectionView.collectionViewLayout = settingsCollectionFlowLayout
    }
}

extension SettingsInsideViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if titleString == "사용자 설정"{
            return settingsViewModel!.userSettingsList.count
        }else if titleString == "계절 설정" {
            return settingsViewModel!.weatherSettingsList.count
        }else if titleString == "알림 설정" {
            return settingsViewModel!.alramSettingsList.count
        }else if titleString == "오류 수집 설정"{
            return settingsViewModel!.colletingErrorsSettingsList.count
        }else if titleString == "버전 정보"{
            return settingsViewModel!.appVersionList.count
        }else {
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == settingsInsideCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsCellCollectionViewCell.description(), for: indexPath) as? SettingsCellCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            if titleString == "사용자 설정"{
                cell.configureView(model: settingsViewModel!.userSettingsList[indexPath.row], indexPath: indexPath, lastIndex: settingsViewModel!.userSettingsList.count)
            }else if titleString == "계절 설정" {
                cell.configureView(model: settingsViewModel!.weatherSettingsList[indexPath.row], indexPath: indexPath, lastIndex: settingsViewModel!.userSettingsList.count)
            }else if titleString == "알림 설정" {
                cell.configureView(model: settingsViewModel!.alramSettingsList[indexPath.row], indexPath: indexPath, lastIndex: settingsViewModel!.userSettingsList.count)
            }else if titleString == "오류 수집 설정"{
                cell.configureView(model: settingsViewModel!.colletingErrorsSettingsList[indexPath.row], indexPath: indexPath, lastIndex: settingsViewModel!.userSettingsList.count)
            }else{
                cell.configureView(model: settingsViewModel!.appVersionList[indexPath.row], indexPath: indexPath, lastIndex: settingsViewModel!.userSettingsList.count)
            }
            
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
}

extension SettingsInsideViewController: UICollectionViewDelegate {
    
}
