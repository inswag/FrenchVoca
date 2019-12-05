//
//  MainTabbarController.swift
//  FrenchVoca
//
//  Created by 박인수 on 07/02/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController {
    
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
        //  일단 설명은, 앱이 처음 시작할 때 메인 탭 바 컨트롤러가 어느 뷰도 존재하지 않는데, 메인에 넣어주어서 뷰 안에 존재하게 만듬.
        
        
        // 파이어베이스를 쓰게 되면 사용할 구문
//        if Auth.auth().currentUser == nil {
//            // Show if not logged in
//
//            return
//        }
        
        
    }
    
}
