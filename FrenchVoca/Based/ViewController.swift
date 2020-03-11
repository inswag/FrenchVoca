//
//  ViewController.swift
//  FrenchVoca
//
//  Created by 박인수 on 25/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK:- Properties
    
    // MARK:- UI Properties
    
    // MARK:- Initialize
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("Deinitialize")
    }
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIComponents()
        setupUILayout()
    }
    
    // MARK:- UI Methods
    
    func setupUIComponents() {
        
    }
    
    func setupUILayout() {
        
    }
    
    // MARK:- Methods
    
}
