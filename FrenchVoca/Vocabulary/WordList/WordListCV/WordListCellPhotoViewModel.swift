//
//  WordListCellPhotoViewModel.swift
//  FrenchVoca
//
//  Created by 박인수 on 03/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

protocol WordListCellPhotoProtocol {
    var wordTitle: String { get }
    var wordPhonetics: String { get }
    var wordPartOfSpeech: String { get }
    var wordGender: String { get }
    var wordNumber: String { get }
    var wordMeaning: String { get }
    var imageName: String { get }
}


struct WordListCellPhotoViewModel: WordListCellPhotoProtocol {
    var wordTitle: String
    var wordPhonetics: String
    var wordPartOfSpeech: String
    var wordGender: String
    var wordNumber: String
    var wordMeaning: String
    var imageName: String

    
    init(content: WordVO) {
        self.wordTitle = content.wordTitle
        self.wordPhonetics = content.wordPhonetics
        self.wordPartOfSpeech = content.wordPartOfSpeech
        self.wordGender = content.wordGender
        self.wordNumber = content.wordNumber
        self.wordMeaning = content.wordMeaning
        self.imageName = content.wordFrenchExam
    }
    
}
