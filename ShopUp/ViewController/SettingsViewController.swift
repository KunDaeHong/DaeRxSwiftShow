//
//  SettingsViewController.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2022/12/26.
//

import UIKit

class SettingsViewController: UIViewController {

    ///SettingsViewController Main Views
    
    //easy Settings view
    @IBOutlet weak var easySettingsCollectionView: UICollectionView!
    private let easySettingsCollectionFlowLayout = UICollectionViewFlowLayout()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureEasySettingsView()
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
}

extension SettingsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    }
}

extension SettingsViewController: UICollectionViewDelegate {
    
}
