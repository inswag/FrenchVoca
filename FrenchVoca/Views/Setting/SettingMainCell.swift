//
//  SettingMainCell.swift
//  FrenchVoca
//
//  Created by 박인수 on 03/04/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class SettingMainCell: UITableViewCell {
    
    static func defineCellHeight() -> CGFloat {
        let cellHeight = (Constant.titleFont!.lineHeight) + (Constant.margin) + (Constant.subTitleFont!.lineHeight)
        return cellHeight
    }
    
    struct Constant {
        static let margin: CGFloat = 20
        static let titleFont = UIFont(name: "Avenir-Light", size: 18)
        static let subTitleFont = UIFont(name: "Avenir-Light", size: 12)
    }
    
    let cellID = "cellID"
    
    // MARK:- UI components
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textAlignment = .left
        label.font = Constant.titleFont
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "subtitle"
        label.textAlignment = .left
        label.font = Constant.subTitleFont
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: cellID)
        
        self.setupUIDesign()
    }
    
    // MARK:- Design
    func setupUIDesign() {
        [titleLabel, subTitleLabel].forEach { self.contentView.addSubview($0) }
        
        self.titleLabel.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: nil, right: self.contentView.rightAnchor, paddingTop: 10, paddingLeft: 30, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
        
        self.subTitleLabel.anchor(top: self.titleLabel.bottomAnchor, left: self.contentView.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 30, paddingBottom: 10, paddingRight: 40, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

