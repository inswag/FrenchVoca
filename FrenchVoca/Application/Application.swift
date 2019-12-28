//
//  Application.swift
//  FrenchVoca
//
//  Created by 박인수 on 28/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

final class Application: NSObject {
    
    static let shared = Application()
    
    var window: UIWindow?
    
//    var notiManager: UNNotiManager
    
    let synthesizer: Synthesizer
    let navigator: Navigator
    
    private override init() {
        synthesizer = Synthesizer.shared
        navigator = Navigator.default
        super.init()
//        presentInitialScreen(in: window)
    }
    
    func presentInitialScreen(in window: UIWindow?) {
        //        updateProvider()
        guard let window = window  else { return }
        self.window = window
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            window.rootViewController = self.navigator.get(segue: .tabs)
        }
        
//        window.backgroundColor = .white
//        window.makeKeyAndVisible()
        
        
    }

}
