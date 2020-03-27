//
//  Navigator.swift
//  FrenchVoca
//
//  Created by 박인수 on 19/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class Navigator {
    
    // MARK: - ALL SCENE
    
    enum Scene {
        case tabs
        case enrollment         // Login
        case signIn
        case notiSetting
        case reception          // Reception
        case delf
        case flex
        case institut
        case institutDetail(url: String)
        case subjectList        // Vocabulary
        case wordList(id: Int)
        case voiceSetting
        case settingMain        // Setting
        case settingModifyInfo
        case settingPeople
        case settingNoti
    }
    
    // MARK:- Scene Method
    
    // 왜 SwiftHub 에서는 옵셔널로 처리했을까?
    func get(segue: Scene) -> UIViewController {
        
        switch segue {
        case .tabs: return MainTabBarController(navigator: self)
        case .enrollment: return EnrollmentViewController()
        case .signIn: return SignInViewController()
        case .notiSetting: return NotiSettingViewController()
        case .reception: return ReceptionViewController()
        case .delf: return DELFViewController()
        case .flex: return FLEXViewController()
        case .institut:
            let viewModel = InstitutViewControllerViewModel()
            return InstitutViewController(navigator: self, viewModel: viewModel)
        case .institutDetail(let url):
            let viewModel = InstitutDetailViewControllerViewModel(url: url)
            let institutDetailViewController = InstitutDetailViewController(navigator: self, viewModel: viewModel)
            institutDetailViewController.modalPresentationStyle = .fullScreen
            return institutDetailViewController
        case .subjectList: return VocabularySubjectListVC(navigator: self)
        case .wordList(let id):
            let viewModel = WordListViewControllerViewModel(id: id)
            return WordListViewController(navigator: self, viewModel: viewModel)
        case .voiceSetting:
            let voiceSettingViewController = WordListVoiceSettingViewController()
            voiceSettingViewController.modalPresentationStyle = .pageSheet
            return voiceSettingViewController
        case .settingMain:
            let settingViewController = SettingViewController(navigator: self)
            return settingViewController
        case .settingModifyInfo:
            let settingModifyInfoViewController = SettingModifyInfoVC()
            settingModifyInfoViewController.modalPresentationStyle = .overCurrentContext
            return settingModifyInfoViewController
        case .settingPeople:
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
            flowLayout.minimumInteritemSpacing = 1.0
            flowLayout.minimumLineSpacing = 1.0
            let settingPeopleCollectionVC = SettingPeopleCollectionVC(collectionViewLayout: flowLayout)
            return settingPeopleCollectionVC
        case .settingNoti:
            let settingNotiVC = SettingNotificationsVC()
            return settingNotiVC
        }
        
    }
    
}
