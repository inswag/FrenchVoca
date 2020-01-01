//
//  WordListCellSentenceViewModel.swift
//  FrenchVoca
//
//  Created by 박인수 on 31/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class WordListCellSentenceViewModel {
    
    // MARK:- Properties
    var name: String
    var phonetics: String
    var partOfSpeech: String
    var gender: String
    var number: String
    var meaning: String
    var frenchExample: String
    var koreanExample: String
    
    // MARK:- Initialize
    init(content: WordVO) {
        self.name = content.wordTitle
        self.phonetics = content.wordPhonetics
        self.partOfSpeech = content.wordPartOfSpeech
        self.gender = content.wordGender
        self.number = content.wordNumber
        self.meaning = content.wordMeaning
        self.frenchExample = content.wordFrenchExam
        self.koreanExample = content.wordKoreanExam
    }
    
}

extension WordListCellSentenceViewModel {
    public func configure(_ view: WordListCellSentence) {
        view.wordTitleLabel.text = name
        view.wordPhoneticsLabel.text = phonetics
        view.wordPartOfSpeechLabel.text = partOfSpeech
        view.wordGenderLabel.text = gender
        view.wordNumberLabel.text = number
        view.wordMeaningLabel.text = meaning
        view.wordFrenchExamLabel.text = frenchExample
        view.wordKoreanExamLabel.text = koreanExample
    }
}

//private let wordVO: [WordVO]
//
//public init(wordVO: [WordVO]) {
//    self.wordVO = wordVO
//}
//    public var name: String {
//        return wordVO.first!.wordTitle
//    }
//
//    public var phonetics: String {
//        return wordVO.wordPhonetics
//    }
//
//    public var partOfSpeech: String {
//        return wordVO.wordPartOfSpeech
//    }
//
//    public var gender: String {
//        return wordVO.wordGender
//    }
//
//    public var number: String {
//        return wordVO.wordNumber
//    }
//
//
//    public var meaing: String {
//        return wordVO.wordMeaning
//    }
//
//    public var frenchExample: String {
//        return wordVO.wordFrenchExam
//    }
//
//    public var koreanExample: String {
//        return wordVO.wordKoreanExam
//    }
