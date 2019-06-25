//
//  VocabularySubjectListHeader.swift
//  FrenchVoca
//
//  Created by 박인수 on 06/02/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class VocabularySubjectListHeader: UICollectionViewCell {
    
    // Complete
    
    static func defineCellSize(cellwidth: CGFloat) -> CGSize {
        let cellHeight = (Constant.vocabularySectionTitleFont!.lineHeight) +
            (Constant.vocabularydivisionLineHeight) +
            (Constant.margin)
        return CGSize(width: cellwidth, height: cellHeight)
    }

    struct Constant {
        static let vocabularySectionTitleFont = UIFont(name: "Avenir-Light", size: 14)
        static let vocabularydivisionLineHeight: CGFloat = 1
        static let margin: CGFloat = 20
    }

    let vocabularySectionTitle: UILabel = {
        let label = UILabel()
        label.text = "Vocabulaire"
        label.textAlignment = .left
        label.font = Constant.vocabularySectionTitleFont
        label.textColor = UIColor.rgb(red: 138, green: 137, blue: 137)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    let vocabularydivisionLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 225, green: 225, blue: 225)
        return view
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProfileContents()
    }
    
    fileprivate func setupProfileContents() {

        [vocabularySectionTitle, vocabularydivisionLine].forEach { self.contentView.addSubview($0) }

        self.vocabularySectionTitle.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: nil, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        self.vocabularydivisionLine.anchor(top: self.vocabularySectionTitle.bottomAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
