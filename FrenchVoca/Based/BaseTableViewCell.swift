//
//  BaseTableViewCell.swift
//  FrenchVoca
//
//  Created by 박인수 on 26/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    //MARK:- Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Methods
    func setupComponents() {
        
    }
    
}
