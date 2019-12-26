//
//  BaseCollectionViewCell.swift
//  FrenchVoca
//
//  Created by 박인수 on 25/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    //MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Methods
    func setupUIComponents() {
        
    }
    
}
