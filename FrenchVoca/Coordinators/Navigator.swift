//
//  Navigator.swift
//  FrenchVoca
//
//  Created by 박인수 on 19/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

class Navigator {
    enum Scene {
        case tabs
        case enrollment         // Login
        case signIn
        case notiSetting
        case reception          // Reception
        case delf
        case flex
        case subjectList        // Vocabulary
        case wordList
        case voiceSetting
        case settingMain        // Setting
        case settingModifyInfo
        case settingPeople
        case settingNoti
    }
    
    // 왜 SwiftHub 에서는 옵셔널로 처리했을까?
    func get(segue: Scene) -> UIViewController {
        switch segue {
        case .tabs: return MainTabBarController()
        case .enrollment: return EnrollmentViewController()
        case .signIn: return SignInViewController()
        case .notiSetting: return NotiSettingViewController()
        case .reception: return ReceptionViewController()
        case .delf: return DELFScheduleViewController()
        case .flex: return FLEXScheduleViewController()
        case .subjectList: return VocabularySubjectListVC()
        case .wordList: return VocabularyWordListVC()
        case .voiceSetting: return VocabularyVoiceSettingVC()
        case .settingMain: return SettingMainTVC()
        case .settingModifyInfo: return SettingModifyInfoVC()
        case .settingPeople: return SettingPeopleCollectionVC()
        case .settingNoti: return SettingNotificationsVC()
        }
    }
    //    func get(segue: Scene) -> UIViewController? {
    //        switch segue {
    //        case .tabs(let viewModel):
    //            let rootVC = HomeTabBarController(viewModel: viewModel, navigator: self)
    //            let detailVC = InitialSplitViewController(viewModel: nil, navigator: self)
    //            let detailNavVC = NavigationController(rootViewController: detailVC)
    //            let splitVC = SplitViewController()
    //            splitVC.viewControllers = [rootVC, detailNavVC]
    //            return splitVC
    //
    //        case .search(let viewModel): return SearchViewController(viewModel: viewModel, navigator: self)
    //        case .languages(let viewModel): return LanguagesViewController(viewModel: viewModel, navigator: self)
    //        case .users(let viewModel): return UsersViewController(viewModel: viewModel, navigator: self)
    //        case .userDetails(let viewModel): return UserViewController(viewModel: viewModel, navigator: self)
    //        case .repositories(let viewModel): return RepositoriesViewController(viewModel: viewModel, navigator: self)
    //        case .repositoryDetails(let viewModel): return RepositoryViewController(viewModel: viewModel, navigator: self)
    //        case .contents(let viewModel): return ContentsViewController(viewModel: viewModel, navigator: self)
    //        case .source(let viewModel): return SourceViewController(viewModel: viewModel, navigator: self)
    //        case .commits(let viewModel): return CommitsViewController(viewModel: viewModel, navigator: self)
    //        case .branches(let viewModel): return BranchesViewController(viewModel: viewModel, navigator: self)
    //        case .releases(let viewModel): return ReleasesViewController(viewModel: viewModel, navigator: self)
    //        case .pullRequests(let viewModel): return PullRequestsViewController(viewModel: viewModel, navigator: self)
    //        case .pullRequestDetails(let viewModel): return PullRequestViewController(viewModel: viewModel, navigator: self)
    //        case .events(let viewModel): return EventsViewController(viewModel: viewModel, navigator: self)
    //        case .notifications(let viewModel): return NotificationsViewController(viewModel: viewModel, navigator: self)
    //        case .issues(let viewModel): return IssuesViewController(viewModel: viewModel, navigator: self)
    //        case .issueDetails(let viewModel): return IssueViewController(viewModel: viewModel, navigator: self)
    //        case .theme(let viewModel): return ThemeViewController(viewModel: viewModel, navigator: self)
    //        case .language(let viewModel): return LanguageViewController(viewModel: viewModel, navigator: self)
    //        case .acknowledgements: return AcknowListViewController()
    //        case .contacts(let viewModel): return ContactsViewController(viewModel: viewModel, navigator: self)
    //
    //        case .whatsNew(let block):
    //            if let versionStore = block.2 {
    //                return WhatsNewViewController(whatsNew: block.0, configuration: block.1, versionStore: versionStore)
    //            } else {
    //                return WhatsNewViewController(whatsNew: block.0, configuration: block.1)
    //            }
    //
    //        case .safari(let url):
    //            UIApplication.shared.open(url, options: [:], completionHandler: nil)
    //            return nil
    //
    //        case .safariController(let url):
    //            let vc = SFSafariViewController(url: url)
    //            return vc
    //
    //        case .webController(let url):
    //            let vc = WebViewController(viewModel: nil, navigator: self)
    //            vc.load(url: url)
    //            return vc
    //        }
    //    }
}
