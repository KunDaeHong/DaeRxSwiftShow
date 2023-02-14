//
//  SettingsInsideViewController.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2023/01/26.
//

import UIKit

class SettingsInsideViewController: UIViewController {
    
    // MARK: SettingsInsideViewController Main Views
    
    @IBOutlet weak var mainTitle: UILabel!
    
    //list Settings view
    var listSettingsCollectionView: UICollectionView = UICollectionView()
    private let listSettingsCollectionFlowLayout = UICollectionViewFlowLayout()
    
    // MARK: Views Data
    var titleString : String = ""
    var dataModel: SettingsCellStuffModel?
    
    
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
    }
    
    private func configureListSettingsView() {
        listSettingsCollectionView.register(SettingsCellCollectionViewCell.self, forCellWithReuseIdentifier: SettingsCellCollectionViewCell.description())
        listSettingsCollectionView.dataSource = self
        listSettingsCollectionFlowLayout.scrollDirection = .vertical
        listSettingsCollectionFlowLayout.itemSize = .init(width: listSettingsCollectionView.bounds.size.width, height: 50)
        listSettingsCollectionFlowLayout.minimumLineSpacing = 0
        listSettingsCollectionFlowLayout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        listSettingsCollectionView.collectionViewLayout = listSettingsCollectionFlowLayout
    }

}

extension SettingsInsideViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
