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
    var loaded = false
    
    private let disposeBag = DisposeBag()
    private var settingsViewModel: SettingsViewModel?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationView()
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loaded = true
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
        settingsCollectionFlowLayout.scrollDirection = .vertical
        if let collectionViewLayout = settingsInsideCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    private func bind() {
        switch(titleString){
        case "사용자 설정" :
            settingsViewModel!.userSettingsList.bind(
                to: settingsInsideCollectionView.rx.items(
                    cellIdentifier: SettingsCellCollectionViewCell.description(),
                    cellType: SettingsCellCollectionViewCell.self))
            {
                (index, model, cell) in
                let indexPath = IndexPath(row: index, section: 0)
                if self.loaded {
                    cell.updateView(model: model)
                }else{
                    cell.configureView(model: model, indexPath: indexPath, lastIndex: self.settingsViewModel!.userSettingsList.value.count, mainWidthSize: self.settingsInsideCollectionView.bounds.size.width)
                }
            }.disposed(by: disposeBag)
            break;
        case "계절 설정" :
            settingsViewModel!.weatherSettingsList.bind(
                to: settingsInsideCollectionView.rx.items(
                    cellIdentifier: SettingsCellCollectionViewCell.description(),
                    cellType: SettingsCellCollectionViewCell.self))
            {
                index, model, cell in
                let indexPath = IndexPath(row: index, section: 0)
                if self.loaded {
                    cell.updateView(model: model)
                }else{
                    cell.configureView(model: model, indexPath: indexPath, lastIndex: self.settingsViewModel!.weatherSettingsList.value.count, mainWidthSize: self.settingsInsideCollectionView.bounds.size.width, completionHandler: {self.settingsViewModel!.changeWeatherSettings(type: model.title)})
                }
            }.disposed(by: disposeBag)
            break;
        case "알림 설정" :
            settingsViewModel!.alramSettingsList.bind(
                to: settingsInsideCollectionView.rx.items(
                    cellIdentifier: SettingsCellCollectionViewCell.description(),
                    cellType: SettingsCellCollectionViewCell.self))
            {
                (index, model, cell) in
                let indexPath = IndexPath(row: index, section: 0)
                if self.loaded {
                    //cell.updateView(model: model)
                }else{
                    cell.configureView(model: model, indexPath: indexPath, lastIndex: self.settingsViewModel!.alramSettingsList.value.count, mainWidthSize: self.settingsInsideCollectionView.bounds.size.width)
                }
            }.disposed(by: disposeBag)
            break;
        case "오류 수집 설정" :
            settingsViewModel!.colletingErrorsSettingsList.bind(
                to: settingsInsideCollectionView.rx.items(
                    cellIdentifier: SettingsCellCollectionViewCell.description(),
                    cellType: SettingsCellCollectionViewCell.self))
            {
                (index, model, cell) in
                let indexPath = IndexPath(row: index, section: 0)
                if self.loaded {
                    cell.updateView(model: model)
                }else{
                    cell.configureView(model: model, indexPath: indexPath, lastIndex: self.settingsViewModel!.colletingErrorsSettingsList.value.count, mainWidthSize: self.settingsInsideCollectionView.bounds.size.width)
                }
            }.disposed(by: disposeBag)
            break;
        case "버전 정보" :
            settingsViewModel!.appVersionList.bind(
                to: settingsInsideCollectionView.rx.items(
                    cellIdentifier: SettingsCellCollectionViewCell.description(),
                    cellType: SettingsCellCollectionViewCell.self))
            {
                (index, model, cell) in
                let indexPath = IndexPath(row: index, section: 0)
                if self.loaded {
                    cell.updateView(model: model)
                }else{
                    cell.configureView(model: model, indexPath: indexPath, lastIndex: self.settingsViewModel!.appVersionList.value.count, mainWidthSize: self.settingsInsideCollectionView.bounds.size.width)
                }
            }.disposed(by: disposeBag)
            break;
        default: break;
        }
    }
}

extension SettingsInsideViewController: UICollectionViewDelegate {
    
}
