//
//  VocabularyCollectionViewSuggestionCell.swift
//  FrenchVoca
//
//  Created by 박인수 on 07/02/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class VocabularyCollectionViewSuggestionCell: UICollectionViewCell {
    
    // Complete
    
    static func defineCellSize(cellwidth: CGFloat) -> CGSize {
        let cellHeight = (Constant.totalMargin) +
            (Constant.vocabularyHeaderUsernameFont!.lineHeight) +
            (Constant.vocabularyHeaderSuggestionFont!.lineHeight)
        return CGSize(width: cellwidth, height: cellHeight)
    }
    
    struct Constant {
        static let totalMargin: CGFloat = 25
        static let vocabularyHeaderUsernameFont = UIFont(name: "Avenir-Black", size: 25)
        static let vocabularyHeaderSuggestionFont = UIFont(name: "Avenir-Book", size: 20)
    }
    
    let suggestionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        let firstLabel = UILabel()
        firstLabel.text = "Insu !"
        firstLabel.textAlignment = .center
        firstLabel.font = Constant.vocabularyHeaderUsernameFont
        firstLabel.textColor = UIColor.rgb(red: 74, green: 74, blue: 74)
        firstLabel.numberOfLines = 1
        firstLabel.adjustsFontSizeToFitWidth = true
        let secondLabel = UILabel()
        secondLabel.text = "Qu'est-ce que vous allez apprendre ?"
        secondLabel.textAlignment = .center
        secondLabel.font = Constant.vocabularyHeaderSuggestionFont
        secondLabel.textColor = UIColor.rgb(red: 74, green: 74, blue: 74)
        secondLabel.numberOfLines = 1
        secondLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(firstLabel)
        view.addSubview(secondLabel)
        firstLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        secondLabel.anchor(top: firstLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 20, paddingBottom: 10, paddingRight: 20, width: 0, height: 0)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProfileContents()
    }
    
    fileprivate func setupProfileContents() {
        self.contentView.addSubview(suggestionView)
        self.suggestionView.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: nil, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: self.contentView.frame.width, height: self.contentView.frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
