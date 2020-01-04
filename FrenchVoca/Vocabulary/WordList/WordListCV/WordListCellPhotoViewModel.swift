//
//  WordListCellPhotoViewModel.swift
//  FrenchVoca
//
//  Created by 박인수 on 03/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

struct WordListCellPhotoViewModel {
    
    // MARK:- Properties
    var word: String
    var phonetics: String
    var partOfSpeech: String
    var gender: String
    var number: String
    var meaning: String
    var frenchExample: String

    // MARK:- Initialize
    init(content: WordVO) {
        self.word = content.wordTitle
        self.phonetics = "[" + content.wordPhonetics + "]"
        self.partOfSpeech = content.wordPartOfSpeech
        self.gender = content.wordGender
        self.number = content.wordNumber
        self.meaning = content.wordMeaning
        self.frenchExample = content.wordFrenchExam
    }
    
}

extension WordListCellPhotoViewModel {
    
    public func configure(_ cell: WordListCellPhoto) {
        cell.wordTitleLabel.text = word
        cell.wordPhoneticsLabel.text = phonetics
        cell.wordPartOfSpeechLabel.text = partOfSpeech
        cell.wordGenderLabel.text = gender
        cell.wordNumberLabel.text = number
        cell.wordMeaningLabel.text = meaning
        cell.showImageView.image = UIImage(named: frenchExample)
    }
}
