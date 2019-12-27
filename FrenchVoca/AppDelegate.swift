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
        setupRoot()
        return true
    }
    
    private func setupRoot() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigator = Navigator()
        window.rootViewController = navigator.get(segue: .tabs)
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        self.window = window
        
    }
    
    
    
}

