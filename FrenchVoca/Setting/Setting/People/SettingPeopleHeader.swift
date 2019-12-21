//
//  SettingPeopleHeader.swift
//  FrenchVoca
//
//  Created by 박인수 on 21/04/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class SettingPeopleHeader: UICollectionViewCell {
    
    // Complete
    
    static func defineCellSize(cellwidth: CGFloat) -> CGSize {
        let cellHeight = (Constant.peopleTitleFont!.lineHeight) +
            (Constant.peopleDivisionLineHeight) +
            (Constant.margin)
        return CGSize(width: cellwidth, height: cellHeight)
    }
    
    struct Constant {
        static let peopleTitleFont = UIFont(name: "Avenir-Light", size: 16)
        static let peopleDivisionLineHeight: CGFloat = 1
        static let margin: CGFloat = 20
    }
    
    let peopleSectionTitle: UILabel = {
        let label = UILabel()
        label.text = "parties"
        label.textAlignment = .left
        label.font = Constant.peopleTitleFont
        label.textColor = UIColor.rgb(red: 138, green: 137, blue: 137)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let peopledivisionLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 225, green: 225, blue: 225)
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProfileContents()
    }
    
    fileprivate func setupProfileContents() {
        
        [peopleSectionTitle, peopledivisionLine].forEach { self.contentView.addSubview($0) }
        
        self.peopleSectionTitle.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: nil, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        self.peopledivisionLine.anchor(top: self.peopleSectionTitle.bottomAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 20, paddingRight: 10, width: 0, height: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
