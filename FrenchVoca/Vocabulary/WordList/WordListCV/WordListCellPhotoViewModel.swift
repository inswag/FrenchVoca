//
//  WordListCellPhotoViewModel.swift
//  FrenchVoca
//
//  Created by 박인수 on 03/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

class WordListCellPhotoViewModel {
    
    // MARK:- Properties
    var word: String
    var phonetics: String
    var partOfSpeech: String
    var confused: String
    var gender: String
    var number: String
    var meaning: String
    var frenchExample: String

    // MARK:- Initialize
    init(content: WordVO) {
        self.word = content.wordTitle
        self.phonetics = "[" + content.wordPhonetics + "]"
        self.partOfSpeech = content.wordPartOfSpeech
        self.confused = content.wordConfused
        self.gender = content.wordGender
        self.number = content.wordNumber
        self.meaning = content.wordMeaning
        self.frenchExample = content.wordFrenchExam
    }
    
}
