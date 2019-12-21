//
//  ApplicationCoordinator.swift
//  FrenchVoca
//
//  Created by 박인수 on 19/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit
import AVFoundation

class ApplicationCoordinator: Coordinator {
    ////  let kanjiStorage: KanjiStorage //  1
    
    let notiManager: UNNotiManager
    let window: UIWindow  // 2
    let rootViewController: UITabBarController  // 3

    
    init(window: UIWindow) { //4
        self.window = window
        self.notiManager = UNNotiManager()
        rootViewController = MainTabBarController()
    }
        
    func start() {  // 6
        let plist = UserDefaults.standard
        // Because of TimeInterval at least 60 seconds Error
        if plist.double(forKey: "알림시간") == 0.0 {
            plist.set(60000, forKey: "알림시간")
            plist.synchronize()
        }
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        notiManager.register()
        
        // AVFoundation
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        } catch let error as NSError {
            print("Error : \(error), \(error.userInfo)")
        }
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch let error as NSError {
            print("Error: Could not setActive to true: \(error), \(error.userInfo)")
        }
    }
    
}
