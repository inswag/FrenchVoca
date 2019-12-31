//
//  WelcomeMainWordNestedCell.swift
//  FrenchVoca
//
//  Created by 박인수 on 11/04/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class WelcomeMainWordNestedCell: UICollectionViewCell {
    
    static func defineCellSize(cellwidth: CGFloat) -> CGSize {
        let cellHeight = (Constant.containerViewHeight)
//            (Constant.titleFont!.lineHeight) +
//            (Constant.subTitleFont!.lineHeight)
        return CGSize(width: cellwidth, height: cellHeight)
    }
    
    struct Constant {
//        static let totalMargin: CGFloat = 5
        static let containerViewHeight: CGFloat = 40  // Border 를 프로그래밍으로 주는게 좋을까 디자인에서 주는게 좋을까?
        
        static let wordFrenchFont = Tools.font.avenirBook(size: 16)
        // Part of speech, Gender, meaning 폰트 사이즈는 굳이 높이에 계산할 필요 없음.
//        static let wordPartOfSpeechFont = UIFont(name: "Avenir-Book", size: 16)
//        static let wordGenderFont = UIFont(name: "Avenir-Book", size: 16)
//        static let wordNumberFont = UIFont(name: "Avenir-Book", size: 16)
//        static let wordMeaningFont = UIFont(name: "Avenir-Book", size: 16)
//        static let wordExampleTitleFont = UIFont(name: "Avenir-LightOblique", size: 14)
//        static let wordFrenchExampleFont = UIFont(name: "Avenir-Book", size: 14)
//        static let wordKoreanExampleFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.0
        view.layer.borderColor = Tools.color.lineDivisionColor.cgColor
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
        return view
    }()
    
    let wordFrenchLabel: UILabel = {
        let label = UILabel()
        label.text = "Amour"
        label.textAlignment = .left
        label.font = Tools.font.avenirBook(size: 16)
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordPartOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.text = "n."
        label.textAlignment = .right
        label.font = Tools.font.avenirBook(size: 16)
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordGenderLabel: UILabel = {
        let label = UILabel()
        label.text = "m."
        label.textAlignment = .right
        label.font = Tools.font.avenirBook(size: 16)
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "s."
        label.textAlignment = .right
        label.font = Tools.font.avenirBook(size: 16)
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordMeaningLabel: UILabel = {
        let label = UILabel()
        label.text = "사랑"
        label.textAlignment = .right
        label.font = Tools.font.avenirBook(size: 16)
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUIComponents() {
        self.contentView.addSubview(containerView)
        // wordExampleTitleLabel, wordFrenchExampleLabel, wordKoreanExampleLabel
        [wordFrenchLabel, wordPartOfSpeechLabel, wordGenderLabel, wordNumberLabel, wordMeaningLabel].forEach {
            self.containerView.addSubview($0)
        }
        
        // 상하좌우 Margin 은 inset 을 통해 구현.
        self.containerView.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: nil, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: (self.contentView.frame.width), height: 40)
        // 150 : iPhone SE 의 화면의 절반을 고려
        self.wordFrenchLabel.anchor(top: self.containerView.topAnchor, left: self.containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 150, height: 0)
        
        self.wordMeaningLabel.anchor(top: nil, left: nil, bottom: self.wordFrenchLabel.bottomAnchor, right: self.containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        self.wordNumberLabel.anchor(top: nil, left: nil, bottom: self.wordFrenchLabel.bottomAnchor, right: self.wordMeaningLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
        self.wordGenderLabel.anchor(top: nil, left: nil, bottom: self.wordFrenchLabel.bottomAnchor, right: self.wordNumberLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
        self.wordPartOfSpeechLabel.anchor(top: nil, left: nil, bottom: self.wordFrenchLabel.bottomAnchor, right: self.wordGenderLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
        // 20
//        self.wordExampleTitleLabel.anchor(top: nil, left: self.containerView.leftAnchor, bottom: self.wordFrenchExampleLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
        
        // 10
//        self.wordFrenchExampleLabel.anchor(top: nil, left: self.containerView.leftAnchor, bottom: self.wordKoreanExampleLabel.topAnchor, right: self.containerView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 5, paddingRight: 10, width: 0, height: 0)
        // 5
//        self.wordKoreanExampleLabel.anchor(top: nil, left: self.containerView.leftAnchor, bottom: self.containerView.bottomAnchor, right: self.containerView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        // 20
    }
    
}
