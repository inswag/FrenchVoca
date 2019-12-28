//
//  VocabularyMenuCollectionViewCell.swift
//  FrenchVoca
//
//  Created by 박인수 on 10/02/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import AVFoundation
import UIKit

class VocabularyWordListCellForSentence: UICollectionViewCell {
    
    static func defineCellSize(cellwidth: CGFloat) -> CGSize {
        let cellHeight = (Constant.outlineHeight) + (Constant.padding) + (Constant.wordTitleFont!.lineHeight) + (Constant.exampleTitleFont!.lineHeight) + (Constant.wordFrenchExamFont!.lineHeight * 3) + (Constant.wordKoreanExamFont!.lineHeight * 2)
        return CGSize(width: cellwidth, height: cellHeight)
    }
    
    struct Constant {
        static let padding: CGFloat = 95 + 5
        static let outlineHeight: CGFloat = 2 + 19 // 2: Outline + 19: wordPhoneticsFontSize
        static let wordTitleFont = UIFont(name: "Avenir-Book", size: 24)
        static let wordPhoneticsFont = UIFont(name: "LucidaGrande-Regular", size: 6)
        static let wordPartOfSpeechFont = UIFont(name: "Avenir-Book", size: 14)
        static let wordGenderFont = UIFont(name: "Avenir-Book", size: 14)
        static let wordNumberFont = UIFont(name: "Avenir-Book", size: 14)
        static let wordMeaningFont = UIFont(name: "Avenir-Book", size: 16)
        static let exampleTitleFont = UIFont(name: "Avenir-Book", size: 14)
        static let wordFrenchExamFont = UIFont(name: "Avenir-Book", size: 14)
        static let wordKoreanExamFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
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
    
    // 발음 속도 조절 슬라이더 + 발음 속도 미리 들어보기 기능 추가. -> 11.20 완료
    let plist = UserDefaults.standard
//    var utteranceRate: Float = 0.3
    

    let singleSynthesizer = Synthesizer.shared
    
    // Available iOS 10+
    @objc func pronunciation() {
        
//        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: self.willSayWord) // 읽어줄 텍스트 지정
        utterance.voice = AVSpeechSynthesisVoice(language: "fr-FR") // 언어 지정
        // 문제상황 : 발음 속도 조절 뷰컨을 만들엇지만 일단 처음에는 기본 값인 0.5가 있어야 겠고,
        // 맨 처음에는 기본값 0.5 로 고정이 맞지만 발음 조정을 했을 경우에는 그 값이 반영되어야 함.
        if plist.float(forKey: "발음속도") == 0.0 {
            utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        } else {
            utterance.rate = plist.float(forKey: "발음속도") //속도 조절
        }
        singleSynthesizer.speak(utterance) // speak 메소드를 통해 설정한 utterance 를 parameter 로 전달해준다.
    }
    
    lazy var sentencePrononciationButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "headset")
        btn.setImage(img, for: .normal)
        btn.addTarget(self, action: #selector(sentencePronunciation), for: .touchUpInside)
        return btn
    }()
    
    
    var willSaySentence = ""
    
    @objc func sentencePronunciation() {
        
        let utterance = AVSpeechUtterance(string: self.willSaySentence)
        utterance.voice = AVSpeechSynthesisVoice(language: "fr-FR")
        if plist.float(forKey: "발음속도") == 0.0 {
            utterance.rate = AVSpeechUtteranceDefaultSpeechRate
            print("앱 처음 실행했을 때 문장발음속도 : \(utterance.rate)")
        } else {
            utterance.rate = plist.float(forKey: "발음속도")
        }
        singleSynthesizer.speak(utterance)
    }
    
    
    // MARK:- TEST
    lazy var stopTTSButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "stop")
        btn.setImage(img, for: .normal)
        btn.addTarget(self, action: #selector(stopTTS), for: .touchUpInside)
        return btn
    }()
    
    @objc func stopTTS() {
        if singleSynthesizer.isSpeaking == true {
            singleSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        }
        
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
        label.textAlignment = .right
        label.font = Constant.wordMeaningFont
        label.textColor = Tools.color.prettyBlack
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let exampleTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Exemple"
        label.textAlignment = .left
        label.font = Constant.exampleTitleFont
        label.textColor = Tools.color.prettyGray
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordFrenchExamLabel: UILabel = {
        let label = UILabel()
        label.text = "Tous les parents sont un grand homme."
        label.textAlignment = .left
        label.font = Constant.wordFrenchExamFont
        label.textColor = Tools.color.prettyBlack
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordKoreanExamLabel: UILabel = {
        let label = UILabel()
        label.text = "모든 부모님은 위대하다."
        label.textAlignment = .left
        label.font = Constant.wordKoreanExamFont
        label.textColor = Tools.color.prettyBlack
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIDesign()
        
        
    
    }
    
    fileprivate func setupUIDesign() {
        [backgroundBorderView].forEach { self.contentView.addSubview($0) }
        [wordTitleLabel, wordPhoneticsLabel, wordPronunciationButton, wordPartOfSpeechLabel, wordGenderLabel, wordNumberLabel, wordMeaningLabel, exampleTitleLabel, sentencePrononciationButton, stopTTSButton, wordFrenchExamLabel, wordKoreanExamLabel].forEach { self.backgroundBorderView.addSubview($0) }
        
        // Here is AutoLayout of Vocabulary Word List Cell By using 'Anchor'
        self.backgroundBorderView.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0)
        self.wordTitleLabel.anchor(top: self.backgroundBorderView.topAnchor, left: self.backgroundBorderView.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: (self.contentView.frame.width / 3), height: 33)
        self.wordPhoneticsLabel.anchor(top: self.wordTitleLabel.bottomAnchor, left: self.backgroundBorderView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        self.wordPronunciationButton.anchor(top: nil, left: self.wordPhoneticsLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        self.wordPronunciationButton.centerYAnchor.constraint(equalTo: self.wordPhoneticsLabel.centerYAnchor).isActive = true
    
        
        self.wordMeaningLabel.anchor(top: nil, left: nil, bottom: self.wordTitleLabel.bottomAnchor, right: self.backgroundBorderView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: (self.contentView.frame.width / 3), height: 22)
        self.wordNumberLabel.anchor(top: self.wordMeaningLabel.bottomAnchor, left: nil, bottom: nil, right: self.backgroundBorderView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
        self.wordGenderLabel.anchor(top: nil, left: nil, bottom: self.wordNumberLabel.bottomAnchor, right: self.wordNumberLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
        self.wordPartOfSpeechLabel.anchor(top: nil, left: nil, bottom: self.wordNumberLabel.bottomAnchor, right: self.wordGenderLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
        
        self.exampleTitleLabel.anchor(top: nil, left: self.backgroundBorderView.leftAnchor, bottom: self.wordFrenchExamLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 5, paddingRight: 0, width: 0, height: 0)
        
        self.sentencePrononciationButton.anchor(top: nil, left: self.exampleTitleLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        self.sentencePrononciationButton.centerYAnchor.constraint(equalTo: self.exampleTitleLabel.centerYAnchor).isActive = true
        
        self.stopTTSButton.anchor(top: nil, left: self.sentencePrononciationButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        self.stopTTSButton.centerYAnchor.constraint(equalTo: self.exampleTitleLabel.centerYAnchor).isActive = true
        
        self.wordFrenchExamLabel.anchor(top: nil, left: self.backgroundBorderView.leftAnchor, bottom: self.wordKoreanExamLabel.topAnchor, right: self.backgroundBorderView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 5, paddingRight: 15, width: 0, height: 0)
        self.wordKoreanExamLabel.anchor(top: nil, left: self.backgroundBorderView.leftAnchor, bottom: self.backgroundBorderView.bottomAnchor, right: self.backgroundBorderView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 15, paddingRight: 15, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override func prepareForReuse() {
        self.wordGenderLabel.textColor = .black
    }
    
    
}
