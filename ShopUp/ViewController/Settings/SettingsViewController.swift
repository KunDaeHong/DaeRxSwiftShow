//
//  SettingsViewController.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2022/12/26.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: SettingsViewController Main Views
    
    //easy Settings view
    @IBOutlet weak var easySettingsCollectionView: UICollectionView!
    private let easySettingsCollectionFlowLayout = UICollectionViewFlowLayout()
    
    //list Settings view
    @IBOutlet weak var listSettingsCollectionView: UICollectionView!
    private let listSettingsCollectionFlowLayout = UICollectionViewFlowLayout()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureEasySettingsView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureListSettingsView()
    }
    
    
    // MARK: View action
    
    //Back Navigation
    @IBAction func GoingToBack(_ sender: Any) {
        if let navCtrl = self.navigationController {
            navCtrl.popViewController(animated: true)
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
            return 4
        }else if collectionView == listSettingsCollectionView {
            return 10
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
            
            cell.configure(
                title: "샘플 설정",
                firstColor: .greenGradientFirstColor,
                secondColor: .greenGradientSecondColor,
                gradientFirstDirection: .LeftB,
                gradientSecondDirection: .rightT,
                ImageView: UIImageView(image: UIImage(systemName: "gearshape.fill", withConfiguration: largeConfig))
                )
            return cell
        }else if collectionView == listSettingsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionListCell.description(), for: indexPath) as? CollectionListCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(
                title: "화면 설정",
                indexPath: indexPath,
                lastIndex: 9,
                border: true,
                borderWidth: 1
            )
            
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
}

extension SettingsViewController: UICollectionViewDelegate {
    
}
