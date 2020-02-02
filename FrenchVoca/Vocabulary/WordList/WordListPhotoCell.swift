//
//  WordListPhotoCell.swift
//  FrenchVoca
//
//  Created by 박인수 on 10/06/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import AVFoundation
import UIKit

class WordListPhotoCell: UITableViewCell {
    
    // MARK:- Properties
    
    var pronunciationWord = ""
    let plist = UserDefaults.standard
    
    // MARK:- P Configure
    
    var viewModel: WordListPhotoCellViewModel! {
        didSet {
            wordTitleLabel.text = viewModel.word
            wordPhoneticsLabel.text = viewModel.phonetics
            wordMeaningLabel.text = viewModel.meaning
            wordPartOfSpeechLabel.text = viewModel.partOfSpeech
            wordGenderLabel.text = viewModel.gender
            if viewModel.confused == "oui" {
                switch wordGenderLabel.text {
                case "f.":
                    wordGenderLabel.textColor = .red
                default:
                    wordGenderLabel.textColor = .blue
                }
            }
            wordNumberLabel.text = viewModel.number
            showImageView.image = UIImage(named: viewModel.frenchExample)
            
            pronunciationWord = viewModel.word
        }
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
        label.textColor = UIColor.red
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
        label.numberOfLines = 1
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
    
    @objc func wordPronunciation() {
        let utterance = AVSpeechUtterance(string: self.pronunciationWord)
        utterance.voice = AVSpeechSynthesisVoice(language: "fr-FR")
        if plist.float(forKey: "발음속도") == 0.0 {
            utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        } else {
            utterance.rate = plist.float(forKey: "발음속도") //속도 조절
        }
        Application.shared.synthesizer.speak(utterance)
    }
    
    let wordPhoneticsLabel: UILabel = {
        let label = UILabel()
        label.text = "[paʀɑ̃]"
        label.textAlignment = .left
        label.font = Tools.font.lucidaGrandeRegular(size: 16)
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
        label.textAlignment = .left
        label.font = Tools.font.avenirBook(size: 16)
        label.textColor = Tools.color.prettyBlack
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let photoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Exemple"
        label.textAlignment = .left
        label.font = Tools.font.avenirBook(size: 14)
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
        [wordOrderLabel, wordTitleLabel, wordPhoneticsLabel, wordPronunciationButton, wordPartOfSpeechLabel, wordGenderLabel, wordNumberLabel, wordMeaningLabel, showImageView, borderView].forEach { self.contentView.addSubview($0) }
        
        wordOrderLabel.snp.makeConstraints { (m) in
            m.top.equalToSuperview().offset(24)
            m.leading.equalToSuperview().offset(24)
            m.trailing.equalToSuperview().offset(-24)
        }
        
        wordTitleLabel.snp.makeConstraints { (m) in
            m.top.equalTo(wordOrderLabel.snp.bottom).offset(15)
            m.leading.equalToSuperview().offset(32)
            m.trailing.equalToSuperview().offset(-32)
            m.height.equalTo(33)
        }
        
        wordPhoneticsLabel.snp.makeConstraints { (m) in
            m.top.equalTo(wordTitleLabel.snp.bottom)
            m.leading.equalToSuperview().offset(32)
        }
        
        wordPronunciationButton.snp.makeConstraints { (m) in
            m.leading.equalTo(wordPhoneticsLabel.snp.trailing).offset(5)
            m.centerY.equalTo(wordPhoneticsLabel.snp.centerY)
            m.width.equalTo(20)
            m.height.equalTo(20)
        }
        
        wordPartOfSpeechLabel.snp.makeConstraints { (m) in
            m.top.equalTo(wordPhoneticsLabel.snp.bottom).offset(10)
            m.leading.equalToSuperview().offset(32)
        }
        
        wordGenderLabel.snp.makeConstraints { (m) in
            m.leading.equalTo(wordPartOfSpeechLabel.snp.trailing).offset(5)
            m.centerY.equalTo(wordPartOfSpeechLabel.snp.centerY)
        }
        
        wordNumberLabel.snp.makeConstraints { (m) in
            m.leading.equalTo(wordGenderLabel.snp.trailing).offset(5)
            m.centerY.equalTo(wordPartOfSpeechLabel.snp.centerY)
        }
        
        wordMeaningLabel.snp.makeConstraints { (m) in
            m.leading.equalTo(wordNumberLabel.snp.trailing).offset(5)
            m.centerY.equalTo(wordPartOfSpeechLabel.snp.centerY)
        }
        
        showImageView.snp.makeConstraints { (m) in
            m.top.equalTo(wordNumberLabel.snp.bottom).offset(15)
            m.trailing.equalToSuperview().offset(-32)
            m.width.equalTo(120)
            m.height.equalTo(120)
        }
        
        borderView.snp.makeConstraints { (m) in
            m.top.equalTo(showImageView.snp.bottom).offset(15)
            m.leading.equalToSuperview().offset(24)
            m.trailing.equalToSuperview().offset(-24)
            m.bottom.equalToSuperview()
            m.height.equalTo(2)
        }
        


        
    }
    
    // MARK: - Reusable Cell Setting
    
    override func prepareForReuse() {
        self.wordGenderLabel.textColor = .black
    }
    
}
