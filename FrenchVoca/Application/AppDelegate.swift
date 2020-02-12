//
//  AppDelegate.swift
//  FrenchVoca
//
//  Created by 박인수 on 24/01/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 얘를 처리할 방법이 없을까..
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
//        self.window = window
        
//        Application.shared.notiManager.register()
        Application.shared.presentInitialScreen(in: window)
        return true
    }

}

