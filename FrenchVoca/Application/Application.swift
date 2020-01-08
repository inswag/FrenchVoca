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
        navigator = Navigator()
        super.init()
    }
    
    func presentInitialScreen(in window: UIWindow) {
        self.window = window
        window.rootViewController = self.navigator.get(segue: .tabs)
    }
    
}
