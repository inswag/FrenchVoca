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
    
    let frenchVocaLogo: UILabel = {
        let label = UILabel()
        label.text = "French Voca"
        label.textAlignment = .center
        label.font = Tools.font.avenirBook(size: 20)
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        return label
    }()
    
    // MARK:- Initialize
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUICommonComponents()
        setupUIComponents()
    }
    
    // MARK:- Methods
    func setupUICommonComponents() {
        navigationItem.titleView = frenchVocaLogo
        self.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationBar.barTintColor = UIColor.red
    }
    
    func setupUIComponents() {
        
    }
    
}

