//
//  WelcomeMainExplanationCell.swift
//  FrenchVocaSecondVersion
//
//  Created by 박인수 on 23/01/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class WelcomeMainExplanationCell: UICollectionViewCell {
    
    static func defineCellSize(cellwidth: CGFloat) -> CGSize {
        let cellHeight = (Constant.totalMargin) +
            (Constant.welcomeCellWordTitleFont!.lineHeight) +
            (Constant.welcomeCellWordFrenchFont!.lineHeight) +
            (Constant.welcomeCellWordExampleTitleFont!.lineHeight) +
            (Constant.welcomeCellWordFrenchExampleFont!.lineHeight * 2) +
            (Constant.welcomeCellWordKoreanExampleFont!.lineHeight * 2) +
            (Constant.welcomeHeaderDivisionLineHeight)
        return CGSize(width: cellwidth, height: cellHeight)
    }
    
    struct Constant {
        static let totalMargin: CGFloat = 75 // 약간의 마진때문에 구분선이 사라져서 +5 추가
        static let welcomeCellWordTitleFont = UIFont(name: "Avenir-Light", size: 14)
        static let welcomeCellWordFrenchFont = UIFont(name: "Avenir-Book", size: 16)
        // Part of speech, Gender, meaning 폰트 사이즈는 굳이 높이에 계산할 필요 없음.
        static let welcomeCellWordPartOfSpeechFont = UIFont(name: "Avenir-Book", size: 16)
        static let welcomeCellWordGenderFont = UIFont(name: "Avenir-Book", size: 16)
        static let welcomeCellWordNumberFont = UIFont(name: "Avenir-Book", size: 16)
        static let welcomeCellWordMeaningFont = UIFont(name: "Avenir-Book", size: 16)
        static let welcomeCellWordExampleTitleFont = UIFont(name: "Avenir-LightOblique", size: 14)
        static let welcomeCellWordFrenchExampleFont = UIFont(name: "Avenir-Book", size: 14)
        static let welcomeCellWordKoreanExampleFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        static let welcomeHeaderDivisionLineHeight: CGFloat = 1
    }
    
    let cellDivisionLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 225, green: 225, blue: 225)
        return view
    }()
    
    let wordTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Mot du jour"
        label.textAlignment = .left
        label.font = Constant.welcomeCellWordTitleFont
        label.textColor = UIColor.rgb(red: 138, green: 137, blue: 137)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordFrenchLabel: UILabel = {
        let label = UILabel()
        label.text = "Amour"
        label.textAlignment = .left
        label.font = Constant.welcomeCellWordFrenchFont
        label.textColor = UIColor.rgb(red: 0, green: 0, blue: 0)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordPartOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.text = "n."
        label.textAlignment = .right
        label.font = Constant.welcomeCellWordPartOfSpeechFont
        label.textColor = UIColor.rgb(red: 0, green: 0, blue: 0)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordGenderLabel: UILabel = {
        let label = UILabel()
        label.text = "m."
        label.textAlignment = .right
        label.font = Constant.welcomeCellWordGenderFont
        label.textColor = UIColor.rgb(red: 0, green: 0, blue: 0)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "s."
        label.textAlignment = .right
        label.font = Constant.welcomeCellWordNumberFont
        label.textColor = UIColor.rgb(red: 0, green: 0, blue: 0)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordMeaningLabel: UILabel = {
        let label = UILabel()
        label.text = "사랑"
        label.textAlignment = .right
        label.font = Constant.welcomeCellWordMeaningFont
        label.textColor = UIColor.rgb(red: 0, green: 0, blue: 0)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordExampleTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Exemple"
        label.textAlignment = .left
        label.font = Constant.welcomeCellWordExampleTitleFont
        label.textColor = UIColor.rgb(red: 0, green: 0, blue: 0)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordFrenchExampleLabel: UILabel = {
        let label = UILabel()
        label.text = "La plus belle phrase d’amour est dite dans le silence d’un regard."
        label.textAlignment = .left
        label.font = Constant.welcomeCellWordFrenchExampleFont
        label.textColor = UIColor.rgb(red: 0, green: 0, blue: 0)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordKoreanExampleLabel: UILabel = {
        let label = UILabel()
        label.text = "가장 아름다운 사랑의 구절은 시선의 고요함에 있다."
        label.textAlignment = .left
        label.font = Constant.welcomeCellWordKoreanExampleFont
        label.textColor = UIColor.rgb(red: 0, green: 0, blue: 0)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellWordContents()
    }
    
    fileprivate func setupCellWordContents() {
        [cellDivisionLineView, wordTitleLabel, wordFrenchLabel, wordPartOfSpeechLabel, wordGenderLabel, wordNumberLabel, wordMeaningLabel, wordExampleTitleLabel, wordFrenchExampleLabel, wordKoreanExampleLabel].forEach { self.contentView.addSubview($0) }
        
        self.cellDivisionLineView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 1)
        
        self.wordTitleLabel.anchor(top: self.cellDivisionLineView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
    
        self.wordFrenchLabel.anchor(top: self.wordTitleLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
    
        self.wordPartOfSpeechLabel.anchor(top: nil, left: nil, bottom: self.wordMeaningLabel.bottomAnchor, right: self.wordGenderLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
        
        self.wordGenderLabel.anchor(top: nil, left: nil, bottom: self.wordMeaningLabel.bottomAnchor, right: self.wordNumberLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
        
        self.wordNumberLabel.anchor(top: nil, left: nil, bottom: self.wordMeaningLabel.bottomAnchor, right: self.wordMeaningLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
        
        self.wordMeaningLabel.anchor(top: nil, left: nil, bottom: self.wordFrenchLabel.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
    
        self.wordExampleTitleLabel.anchor(top: self.wordFrenchLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        self.wordFrenchExampleLabel.anchor(top: self.wordExampleTitleLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 10, paddingLeft: 35, paddingBottom: 0, paddingRight: 35, width: 0, height: 0)
        
        self.wordKoreanExampleLabel.anchor(top: self.wordFrenchExampleLabel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 5, paddingLeft: 35, paddingBottom: 20, paddingRight: 35, width: 0, height: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

