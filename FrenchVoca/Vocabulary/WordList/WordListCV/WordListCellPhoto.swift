//
//  WordListCellPhoto.swift
//  FrenchVoca
//
//  Created by 박인수 on 10/06/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit
import AVFoundation

class WordListCellPhoto: UICollectionViewCell {
    
    static func defineCellSize(cellwidth: CGFloat) -> CGSize {
        let cellHeight = (Constant.padding) +
            (Constant.outlineHeight) +
            (Constant.wordTitleFont!.lineHeight) +
            (Constant.wordMeaningFont!.lineHeight) +
            (Constant.wordPartOfSpeechFont!.lineHeight)
        return CGSize(width: cellwidth, height: cellHeight)
    }
    
    struct Constant {
        static let padding: CGFloat = 95 + 5 // 20 + 20 + 20 + 15 + 15
        static let outlineHeight: CGFloat = 2 + 19 // 2: Outline + 19: wordPhoneticsFontSize
        static let wordTitleFont = UIFont(name: "Avenir-Book", size: 24)
        static let wordPhoneticsFont = UIFont(name: "LucidaGrande-Regular", size: 6)
        static let wordPartOfSpeechFont = UIFont(name: "Avenir-Book", size: 14)
        static let wordGenderFont = UIFont(name: "Avenir-Book", size: 14)
        static let wordNumberFont = UIFont(name: "Avenir-Book", size: 14)
        static let wordMeaningFont = UIFont(name: "Avenir-Book", size: 16)
        static let exampleTitleFont = UIFont(name: "Avenir-Book", size: 14)
    }

    
    let backgroundBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1.0
        view.layer.borderColor = Tools.color.lineDivisionColor.cgColor
        return view
    }()
    
    let wordTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Parents"
        label.textAlignment = .left
        label.font = Constant.wordTitleFont
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var wordPronunciationButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "headset")
        btn.setImage(img, for: .normal)
        btn.addTarget(self, action: #selector(pronunciation), for: .touchUpInside)
        return btn
    }()
    
    var willSayWord = ""
    
    let plist = UserDefaults.standard
    let singleSynthesizer = Synthesizer.shared
    
    @objc func pronunciation() {
        print("ok button")

        let utterance = AVSpeechUtterance(string: self.willSayWord)
        utterance.voice = AVSpeechSynthesisVoice(language: "fr-FR")
        
        if plist.float(forKey: "발음속도") == 0.0 {
            utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        } else {
            utterance.rate = plist.float(forKey: "발음속도") //속도 조절
        }
        singleSynthesizer.speak(utterance)
    }
    
    let wordPhoneticsLabel: UILabel = {
        let label = UILabel()
        label.text = "[paʀɑ̃]"
        label.textAlignment = .left
        label.font = Constant.wordPhoneticsFont
        label.textColor = Tools.color.mediumBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordPartOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.text = "n."
        label.textAlignment = .right
        label.font = Constant.wordPartOfSpeechFont
        label.textColor = Tools.color.prettyBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordGenderLabel: UILabel = {
        let label = UILabel()
        label.text = "m. f."
        label.textAlignment = .right
        label.font = Constant.wordGenderFont
        label.textColor = Tools.color.prettyBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "pl."
        label.textAlignment = .right
        label.font = Constant.wordNumberFont
        label.textColor = Tools.color.prettyBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordMeaningLabel: UILabel = {
        let label = UILabel()
        label.text = "부모님"
        label.textAlignment = .left
        label.font = Constant.wordMeaningFont
        label.textColor = Tools.color.prettyBlack
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let photoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Exemple"
        label.textAlignment = .left
        label.font = Constant.exampleTitleFont
        label.textColor = Tools.color.prettyGray
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let showImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 3
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.black.cgColor
        iv.clipsToBounds = true
        return iv
    }()
    
//    let imageWidthAndHeight: CGFloat = (Constant.wordTitleFont!.lineHeight) + (Constant.wordPhoneticsFont!.lineHeight) + (Constant.wordMeaningFont!.lineHeight) + (Constant.wordPartOfSpeechFont!.lineHeight) + 35
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIComponents()
    }
    
    fileprivate func setupUIComponents() {
        [backgroundBorderView].forEach { self.contentView.addSubview($0) }
        [wordTitleLabel, wordPhoneticsLabel, wordPronunciationButton, wordPartOfSpeechLabel, wordGenderLabel, wordNumberLabel, wordMeaningLabel, showImageView].forEach { self.backgroundBorderView.addSubview($0) }
        
        // Here is AutoLayout of Vocabulary Word List Cell By using 'Anchor'
        self.backgroundBorderView.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0)
        
        self.wordTitleLabel.anchor(top: self.backgroundBorderView.topAnchor, left: self.backgroundBorderView.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: (self.contentView.frame.width / 3), height: 33)
        
        self.wordPhoneticsLabel.anchor(top: self.wordTitleLabel.bottomAnchor, left: self.backgroundBorderView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        self.wordPronunciationButton.anchor(top: nil, left: self.wordPhoneticsLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        self.wordPronunciationButton.centerYAnchor.constraint(equalTo: self.wordPhoneticsLabel.centerYAnchor).isActive = true
        
        
        
        self.wordMeaningLabel.anchor(top: self.wordPronunciationButton.bottomAnchor, left: self.backgroundBorderView.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: (self.contentView.frame.width / 3), height: 22)
        
        self.wordPartOfSpeechLabel.anchor(top: self.wordMeaningLabel.bottomAnchor, left: self.backgroundBorderView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        self.wordGenderLabel.anchor(top: nil, left: self.wordPartOfSpeechLabel.rightAnchor, bottom: self.wordPartOfSpeechLabel.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        self.wordNumberLabel.anchor(top: nil, left: self.wordGenderLabel.rightAnchor, bottom: self.wordPartOfSpeechLabel.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
        
        self.showImageView.anchor(top: self.backgroundBorderView.topAnchor, left: nil, bottom: nil, right: self.backgroundBorderView.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: 120, height: 120)
        
//        self.photoTitleLabel.anchor(top: nil, left: self.backgroundBorderView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 5, paddingRight: 0, width: 0, height: 0)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.wordGenderLabel.textColor = .black
    }
    
}