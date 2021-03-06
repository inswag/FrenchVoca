//
//  WordListSentenceCellViewModel.swift
//  FrenchVoca
//
//  Created by 박인수 on 31/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class WordListSentenceCellViewModel {
    
    // MARK:- Properties
    var word: String
    var phonetics: String
    var partOfSpeech: String
    var confused: String
    var gender: String
    var number: String
    var meaning: String
    var frenchExample: String
    var koreanExample: String
    
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
        self.koreanExample = content.wordKoreanExam
    }
    
}
