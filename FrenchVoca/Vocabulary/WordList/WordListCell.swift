//
//  WordListCell.swift
//  FrenchVoca
//
//  Created by Insu Park on 2020/01/31.
//  Copyright © 2020 inswag. All rights reserved.
//

import AVFoundation
import UIKit

class WordListCell: UITableViewCell {
    
    // MARK:- Property
    
    let plist = UserDefaults.standard
    var pronunciationWord: String = "단어의 발음"
    var pronunciationSentence: String = "문장의 발음"
    
    // MARK:- P Configure
    
    var viewModel: WordListCellSentenceViewModel! {
        didSet {
            wordTitleLabel.text = viewModel.word
//            wordPhoneticsLabel.text = viewModel.phonetics
//            wordMeaningLabel.text = viewModel.meaning
//            wordPartOfSpeechLabel.text = viewModel.partOfSpeech
//            wordGenderLabel.text = viewModel.gender
//            if viewModel.confused == "oui" {
//                switch wordGenderLabel.text {
//                case "f.":
//                    wordGenderLabel.textColor = .red
//                default:
//                    wordGenderLabel.textColor = .blue
//                }
//            }
//            wordNumberLabel.text = viewModel.number
            wordFrenchExamLabel.text = viewModel.frenchExample
            wordKoreanExamLabel.text = viewModel.koreanExample
//
//            pronunciationWord = viewModel.word
//            pronunciationSentence = viewModel.frenchExample
        }
    }
    
    struct Constant {
        static let padding: CGFloat = 95 + 5
        static let outlineHeight: CGFloat = 2 + 19 // 2: Outline + 19: wordPhoneticsFontSize
    
    }
    
    
    // MARK:- View Properties
    
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = Tools.color.lineDivisionColor
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        return view
    }()
    
    let wordOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "Numéro 1"
        label.textAlignment = .left
        label.font = Tools.font.avenirBook(size: 12)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    let wordTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Parents"
        label.textAlignment = .left
        label.font = Tools.font.avenirBook(size: 24)
        label.textColor = UIColor.black
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var wordPronunciationButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "headset")
        btn.setImage(img, for: .normal)
        btn.addTarget(self, action: #selector(wordPronunciation), for: .touchUpInside)
        return btn
    }()

    // Available iOS 10+
    @objc func wordPronunciation() {
        let utterance = AVSpeechUtterance(string: self.pronunciationWord) // 읽어줄 텍스트 지정
        utterance.voice = AVSpeechSynthesisVoice(language: "fr-FR") // 언어 지정
        // 문제상황 : 발음 속도 조절 뷰컨을 만들엇지만 일단 처음에는 기본 값인 0.5가 있어야 겠고,
        // 맨 처음에는 기본값 0.5 로 고정이 맞지만 발음 조정을 했을 경우에는 그 값이 반영되어야 함.
        if plist.float(forKey: "발음속도") == 0.0 {
            utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        } else {
            utterance.rate = plist.float(forKey: "발음속도") //속도 조절
        }
        Application.shared.synthesizer.speak(utterance) // speak 메소드를 통해 설정한 utterance 를 parameter 로 전달해준다.
    }
    
    lazy var sentencePrononciationButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "headset")
        btn.setImage(img, for: .normal)
        btn.addTarget(self, action: #selector(sentencePronunciation), for: .touchUpInside)
        return btn
    }()
    
    @objc func sentencePronunciation() {
        let utterance = AVSpeechUtterance(string: self.pronunciationSentence)
        utterance.voice = AVSpeechSynthesisVoice(language: "fr-FR")
        if plist.float(forKey: "발음속도") == 0.0 {
            utterance.rate = AVSpeechUtteranceDefaultSpeechRate
            print("앱 처음 실행했을 때 문장발음속도 : \(utterance.rate)")
        } else {
            utterance.rate = plist.float(forKey: "발음속도")
        }
        Application.shared.synthesizer.speak(utterance)
    }
    
    lazy var stopPronunciationButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "stop")
        btn.setImage(img, for: .normal)
        btn.addTarget(self, action: #selector(stopPronunciation), for: .touchUpInside)
        return btn
    }()
    
    @objc func stopPronunciation() {
        if Application.shared.synthesizer.isSpeaking == true {
            Application.shared.synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        }
    }
    
    let wordPhoneticsLabel: UILabel = {
        let label = UILabel()
        label.text = "[paʀɑ̃]"
        label.textAlignment = .left
        label.font = Tools.font.lucidaGrandeRegular(size: 6)
        label.textColor = Tools.color.mediumBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordPartOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.text = "n."
        label.textAlignment = .right
        label.font = Tools.font.avenirBook(size: 14)
        label.textColor = Tools.color.prettyBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordGenderLabel: UILabel = {
        let label = UILabel()
        label.text = "m. f."
        label.textAlignment = .right
        label.font = Tools.font.avenirBook(size: 14)
        label.textColor = Tools.color.prettyBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "pl."
        label.textAlignment = .right
        label.font = Tools.font.avenirBook(size: 14)
        label.textColor = Tools.color.prettyBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordMeaningLabel: UILabel = {
        let label = UILabel()
        label.text = "부모님"
        label.textAlignment = .right
        label.font = Tools.font.avenirBook(size: 16)
        label.textColor = Tools.color.prettyBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let exampleTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Exemple"
        label.textAlignment = .left
        label.font = Tools.font.avenirBook(size: 14)
        label.textColor = Tools.color.prettyGray
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    let wordFrenchExamLabel: UILabel = {
        let label = UILabel()
        label.text = "Tous les parents sont un grand homme."
        label.textAlignment = .left
        label.font = Tools.font.avenirBook(size: 14)
        label.textColor = Tools.color.prettyBlack
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    let wordKoreanExamLabel: UILabel = {
        let label = UILabel()
        label.text = "모든 부모님은 위대하다."
        label.textAlignment = .left
        label.font = Tools.font.appleSDGothicNeoRegular(size: 12)
        label.textColor = Tools.color.prettyBlack
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    // MARK:- Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: String(describing: WordListViewController.self))
        setupUIComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- UI Layout
    
    fileprivate func setupUIComponents() {

        [wordOrderLabel, wordTitleLabel, exampleTitleLabel, wordFrenchExamLabel, wordKoreanExamLabel, borderView].forEach { self.contentView.addSubview($0)
        }
        
        wordOrderLabel.snp.makeConstraints { (m) in
            m.top.equalToSuperview().offset(24)
            m.leading.equalToSuperview().offset(24)
            m.trailing.equalToSuperview().offset(-24)
        }
        
        wordTitleLabel.snp.makeConstraints { (m) in
            m.top.equalTo(wordOrderLabel.snp.bottom).offset(15)
            m.leading.equalToSuperview().offset(32)
            m.width.equalTo(160)
//            m.height.equalTo(33)
        }
        
        exampleTitleLabel.snp.makeConstraints { (m) in
            m.top.equalTo(wordTitleLabel.snp.bottom).offset(20)
            m.leading.equalToSuperview().offset(32)
        }
        
        wordFrenchExamLabel.snp.makeConstraints { (m) in
            m.top.equalTo(exampleTitleLabel.snp.bottom).offset(5)
            m.leading.equalToSuperview().offset(40)
            m.trailing.equalToSuperview().offset(-35)
        }
        
        wordKoreanExamLabel.snp.makeConstraints { (m) in
            m.top.equalTo(wordFrenchExamLabel.snp.bottom).offset(5)
            m.leading.equalToSuperview().offset(40)
            m.trailing.equalToSuperview().offset(-35)
        }
        
        borderView.snp.makeConstraints { (m) in
            m.top.equalTo(wordKoreanExamLabel.snp.bottom).offset(15)
            m.leading.equalToSuperview().offset(24)
            m.trailing.equalToSuperview().offset(-24)
            m.bottom.equalToSuperview()
            m.height.equalTo(2)
        }
        
        
        // Here is AutoLayout of Vocabulary Word List Cell By using 'Anchor'
//        self.backgroundBorderView.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0)
//        self.wordTitleLabel.anchor(top: self.backgroundBorderView.topAnchor, left: self.backgroundBorderView.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: (self.contentView.frame.width / 3), height: 33)
//        self.wordPhoneticsLabel.anchor(top: self.wordTitleLabel.bottomAnchor, left: self.backgroundBorderView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        self.wordPronunciationButton.anchor(top: nil, left: self.wordPhoneticsLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
//        self.wordPronunciationButton.centerYAnchor.constraint(equalTo: self.wordPhoneticsLabel.centerYAnchor).isActive = true
//
//
//        self.wordMeaningLabel.anchor(top: nil, left: nil, bottom: self.wordTitleLabel.bottomAnchor, right: self.backgroundBorderView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: (self.contentView.frame.width / 3), height: 22)
//        self.wordNumberLabel.anchor(top: self.wordMeaningLabel.bottomAnchor, left: nil, bottom: nil, right: self.backgroundBorderView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
//        self.wordGenderLabel.anchor(top: nil, left: nil, bottom: self.wordNumberLabel.bottomAnchor, right: self.wordNumberLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
//        self.wordPartOfSpeechLabel.anchor(top: nil, left: nil, bottom: self.wordNumberLabel.bottomAnchor, right: self.wordGenderLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
//
//        self.exampleTitleLabel.anchor(top: nil, left: self.backgroundBorderView.leftAnchor, bottom: self.wordFrenchExamLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 5, paddingRight: 0, width: 0, height: 0)
//
//        self.sentencePrononciationButton.anchor(top: nil, left: self.exampleTitleLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
//        self.sentencePrononciationButton.centerYAnchor.constraint(equalTo: self.exampleTitleLabel.centerYAnchor).isActive = true
//
//        self.stopPronunciationButton.anchor(top: nil, left: self.sentencePrononciationButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
//        self.stopPronunciationButton.centerYAnchor.constraint(equalTo: self.exampleTitleLabel.centerYAnchor).isActive = true
//
//        self.wordFrenchExamLabel.anchor(top: nil, left: self.backgroundBorderView.leftAnchor, bottom: self.wordKoreanExamLabel.topAnchor, right: self.backgroundBorderView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 5, paddingRight: 15, width: 0, height: 0)
//        self.wordKoreanExamLabel.anchor(top: nil, left: self.backgroundBorderView.leftAnchor, bottom: self.backgroundBorderView.bottomAnchor, right: self.backgroundBorderView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 15, paddingRight: 15, width: 0, height: 0)
    }
    
    
    // MARK: - Reusable Cell Setting
    
    override func prepareForReuse() {
        self.wordGenderLabel.textColor = Tools.color.prettyBlack
    }
    
}


