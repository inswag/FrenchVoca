 //
//  InstitutViewControllerViewModel.swift
//  FrenchVoca
//
//  Created by Insu Park on 2020/03/11.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit
import SwiftSoup

class InstitutViewControllerViewModel {
    
    // MARK:- Properties
    
    var titleArray: [String] = []
    var imageArray: [String] = []
    var nextArray: [String] = []
    
    // MARK:- UI Properties
    
    // MARK:- Initialize
    
    init() {
    
    }

    // MARK:- UI Methods
    
    // MARK:- Methods
    
    func fetchHTMLParsingResult(completion: @escaping () -> ()) {
        let urlAddress = "https://www.institutfrancais-seoul.com/ko/2017-%eb%ac%b8%ed%99%94-%ea%b5%90%ec%9c%a1-%ea%b3%bc%ed%95%99-%eb%89%b4%ec%8a%a4/"
        
        guard let url = URL(string: urlAddress) else { return }
        
//        DispatchQueue.global().async {
            
            do {
                let html = try String(contentsOf: url, encoding: .utf8)
                let doc: Document = try SwiftSoup.parse(html)
                
                let linkTitles: Elements = try doc.select("div.av_table_col.portfolio-grid-image").select("a")
                
                for element in linkTitles.array() {
                    self.titleArray.append(try element.attr("title"))
                    print("Title : ", try element.attr("title"))
                }
                
                let linkImages: Elements = try doc.select("div.av_table_col.portfolio-grid-image").select("img")
                
                for element in linkImages.array() {
                    self.imageArray.append(try element.attr("src"))
                    print("image : ", try element.attr("src"))
                }
                
                let linkNext: Elements = try doc.select("div.av_table_col.portfolio-grid-image").select("a")
                
                for element in linkNext.array() {
                    self.nextArray.append(try element.attr("href"))
                    print("Next URL : ", try element.attr("href"))
                }
                
                completion()
                
            } catch let error {
                print("Error: ", error)
            }
//        }
        
        
    }
    
    
    
    
    
    
    
}
