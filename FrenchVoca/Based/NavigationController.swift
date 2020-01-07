//
//  NavigationController.swift
//  FrenchVoca
//
//  Created by 박인수 on 25/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit
import SnapKit

class NavigationController: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUIComponents()
    }
    
    // MARK:- Methods
    func setupUIComponents() {
        self.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationBar.barTintColor = UIColor.red
    }
    
}

