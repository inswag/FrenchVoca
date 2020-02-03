//
//  WordListViewControllerViewModel.swift
//  FrenchVoca
//
//  Created by Insu Park on 2020/02/02.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

class WordListViewControllerViewModel {
    
    // MARK:- Properties
    
    // DAO Provider
    var wordDAO = WordDAO()
    var subjectDAO = SubjectDAO()
    
    var wordList: [WordVO]?
    var subjectInfo: [SubjectVO]?
    
//    var fetchedProduct: Product?
    var id: Int
    
    // MARK:- Initialize
    
    init(id: Int) {
        self.id = id
    }
    
    // MARK:- Methods
    
    func fetchSelectedSubject(id: Int) {
        self.subjectInfo = self.subjectDAO.get(subjectCd: id)
    }
    
    func fetchSelectedWords(id: Int) {
        self.wordList = self.wordDAO.find(subjectCd: id)
    }
}
