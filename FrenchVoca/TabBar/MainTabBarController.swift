//
//  MainTabbarController.swift
//  FrenchVoca
//
//  Created by 박인수 on 07/02/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit


class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            // UserDefault 에 저장된 이름과 소속이 없으면 등록창을, 그렇지 않으면 바로 메인 화면을 보여주게 된다.
            let plist = UserDefaults.standard
            if let username = plist.string(forKey: "이름"), let position = plist.string(forKey: "소속") {
                print("My name: \(username), My position: \(position)")
            } else {
                let enrollmentViewController = EnrollmentViewController()
                let navController = UINavigationController(rootViewController: enrollmentViewController)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            }
        }
        
        setupViewControllers()
    }
    
    
    func setupViewControllers() {
        let welcomeSelected = UIImage(named: "A_selected")
        let welcomeUnselected = UIImage(named: "A_unselected")
        let vocaSelected = UIImage(named: "V_selected")
        let vocaUnselected = UIImage(named: "V_unselected")
        let settingSelected = UIImage(named: "P_selected")
        let settingUnselected = UIImage(named: "P_unselected")
        
        // Welcome
        let welcomeNaviController = templateNavController(unselectedImage: welcomeUnselected!,
                                                          selectedImage: welcomeSelected!,
                                                          rootViewController: WelcomeViewController())
        
        // Vocabulary
        let vocabularyNaviController = templateNavController(unselectedImage: vocaUnselected!,
                                                             selectedImage: vocaSelected!,
                                                             rootViewController: VocabularySubjectListVC())
        
        // Setting
        let settingNaviController = UINavigationController(rootViewController: SettingMainTVC())
        settingNaviController.tabBarItem.selectedImage = settingSelected!
        settingNaviController.tabBarItem.image = settingUnselected!
        
        
        // Set up
        tabBar.tintColor = .black
        viewControllers = [welcomeNaviController,
                           vocabularyNaviController,
                           settingNaviController]
        
        // Modify tab bar item insets & title
        guard let items = tabBar.items else { return }
        
        items[0].title = "Accueil"
        items[1].title = "Vocabulaire"
        items[2].title = "Paramètre"
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
        
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
    
}

// 6face8a577050b168c87eb2a938074c8
