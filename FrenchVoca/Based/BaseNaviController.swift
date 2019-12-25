//
//  BaseNaviController.swift
//  FrenchVoca
//
//  Created by 박인수 on 25/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class BaseNaviController: UINavigationController {
        
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIComponents()
    }
    
    // MARK:- Methods
    func setupUIComponents() {
        self.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationBar.barTintColor = UIColor.white
    }
    
}

