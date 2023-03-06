//
//  SettingsViewModel.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2023/01/17.
//

import UIKit
import RxSwift
import RxCocoa

class SettingsViewModel {
    
    let settingsList: [String] = ["사용자 설정", "계절 설정", "알림 설정", "오류 수집 설정", "버전 정보"]
    
    let easySettingsList = BehaviorRelay<[EasySettingsModel]>(value: [
        EasySettingsModel(title: "테마 변경", firstColor: .darkBlue, secondColor: .nightBlue, toggle: false, value: "", image: UIImage()),
        EasySettingsModel(title: "계절 설정", firstColor: .greenGradientFirstColor, secondColor: .greenGradientSecondColor, toggle: false, value: "Auto"),
        EasySettingsModel(title: "알림", firstColor: .limeYellowGradientFirstColor, secondColor: .limeYellowGradientSecondColor, toggle: true, value: ""),
        EasySettingsModel(title: "알림 소리", firstColor: .limeYellowGradientFirstColor, secondColor: .limeYellowGradientSecondColor, toggle: true, value: ""),
        EasySettingsModel(title: "알림 진동", firstColor: .limeYellowGradientFirstColor, secondColor: .limeYellowGradientSecondColor, toggle: true, value: "")
    ])
    
    let userSettingsList : [SettingsCellStuffModel] = [
        SettingsCellStuffModel(
            title: "이름",
            subTitleOption: true,
            subTitle: "내 이름",
            modifiedOption: true
        ),
        SettingsCellStuffModel(
            title: "나이",
            subTitleOption: true,
            subTitle: "55",
            modifiedOption: true
        )
    ]
    
    let weatherSettingsList: [SettingsCellStuffModel] = [
        SettingsCellStuffModel(title: "봄", imageCell: true, image: UIImage()),
        SettingsCellStuffModel(title: "자동", decideOption: true, checkMark: false),
        SettingsCellStuffModel(title: "봄", decideOption: true, checkMark: true),
        SettingsCellStuffModel(title: "여름", decideOption: true, checkMark: false),
        SettingsCellStuffModel(title: "가을", decideOption: true, checkMark: false),
        SettingsCellStuffModel(title: "겨울", decideOption: true, checkMark: false),
    ]
    
    let alramSettingsList: [SettingsCellStuffModel] = [
        SettingsCellStuffModel(title: "알림", decideOption: true, checkMark: true),
        SettingsCellStuffModel(title: "알림 소리", decideOption: true, checkMark: true),
        SettingsCellStuffModel(title: "알림 진동", decideOption: true, checkMark: true),
    ]
    
    let colletingErrorsSettingsList: [SettingsCellStuffModel] = [
        SettingsCellStuffModel(title: "에러를 수집하여 앱 개선에 도움", decideOption: true, checkMark: AppSettings.shared.app_collect_errors)
    ]
    
    let appVersionList: [SettingsCellStuffModel] = [
        SettingsCellStuffModel(title: "버전", subTitle: AppSettings.shared.app_version),
        SettingsCellStuffModel(title: "리소스 파일 버전", subTitle: AppSettings.shared.app_resources_version),
        SettingsCellStuffModel(title: "현재 버전의 보증", subTitle: AppSettings.shared.app_version_warranty ? "제한 보증 가능" : "불가능")
    ]
    
    init() {
        bringAppSettings()
    }

    
    private func bringAppSettings() {
        
        if AppSettings.shared.dark_theme {
            var update = easySettingsList.value
            update[0].image = UIImage(named: "NightStars")
            easySettingsList.accept(update)
        }else{
            var update = easySettingsList.value
            update[0].image = UIImage(named: "NightStars")
            easySettingsList.accept(update)
        }
        
        if AppSettings.shared.weather_auto{
            var update = easySettingsList.value
            let autoLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 160, height: 200))
            autoLabel.text = "AUTO"
            autoLabel.textAlignment = .center
            autoLabel.textColor = .white
            autoLabel.font = .systemFont(ofSize: 30, weight: .bold)
            UIGraphicsBeginImageContext(autoLabel.frame.size)
            if let currentContext = UIGraphicsGetCurrentContext() {
                autoLabel.layer.render(in: currentContext)
            }
            let labelImg = UIGraphicsGetImageFromCurrentImageContext()
            update[1].title = "계절 설정"
            update[1].image = labelImg
            easySettingsList.accept(update)
        }else{
            var update = easySettingsList.value
            update[1].image = UIImage(named: "autoWeather")
            easySettingsList.accept(update)
        }
        // 앱설정을 들고와야 하는 코드가 필요. 단 이부분으로 부터 시작. 지금 시작.
    }
}

//For Easy Settings List in ViewModel
struct EasySettingsModel {
    var title: String
    let firstColor: AppColorType
    let secondColor: AppColorType
    let toggle: Bool
    let value: String
    var image: UIImage?
    
    init(title: String, firstColor: AppColorType, secondColor: AppColorType, toggle: Bool, value: String, image: UIImage? = nil) {
        self.title = title
        self.firstColor = firstColor
        self.secondColor = secondColor
        self.toggle = toggle
        self.value = value
        self.image = image
    }
}
