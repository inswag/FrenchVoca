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
    
    // MARK:- Cell Type
    
    enum CellType: Int {
        case will
        case now
        case totalCount
    }
    
    // MARK:- Properties
    
    var willTitleArray: [String] = []
    var willImageArray: [String] = []
    var willNextArray: [String] = []
    
    var nowTitleArray: [String] = []
    var nowImageArray: [String] = []
    var nowNextArray: [String] = []
    
    // MARK:- UI Properties
    
    // MARK:- Initialize
    
    init() {
    
    }

    // MARK:- UI Methods
    
    // MARK:- Methods
    
    func fetchHTMLParsingResultWill(completion: @escaping () -> ()) {
        
         let urlAddress = "https://www.institutfrancais-seoul.com/ko/2017-%eb%ac%b8%ed%99%94-%ea%b5%90%ec%9c%a1-%ea%b3%bc%ed%95%99-%eb%89%b4%ec%8a%a4/"
        
        guard let url = URL(string: urlAddress) else { return }
            do {
                let html = try String(contentsOf: url, encoding: .utf8)
                let doc: Document = try SwiftSoup.parse(html)
                
                let firstLinkTitles: Elements = try doc.select("div#av-sc-portfolio-1").select("div.av_table_col.portfolio-grid-image").select("a")
                
                
                for element in firstLinkTitles.array() {
                    self.willTitleArray.append(try element.attr("title"))
                    print("Title : ", try element.attr("title"))
                }
                
                let firstLinkImages: Elements = try doc.select("div.av_table_col.portfolio-grid-image").select("img")
                
                for element in firstLinkImages.array() {
                    self.willImageArray.append(try element.attr("src"))
                    print("image : ", try element.attr("src"))
                }
                
                let firstLinkNext: Elements = try doc.select("div.av_table_col.portfolio-grid-image").select("a")
                
                for element in firstLinkNext.array() {
                    self.willNextArray.append(try element.attr("href"))
                    print("Next URL : ", try element.attr("href"))
                }
                
                
                let secondLinkTitles: Elements = try doc.select("div#av-sc-portfolio-2").select("div.av_table_col.portfolio-grid-image").select("a")
                
                for element in secondLinkTitles.array() {
                    self.nowTitleArray.append(try element.attr("title"))
                    print("Title 2 : ", try element.attr("title"))
                }
                
                let secondLinkImages: Elements = try doc.select("div#av-sc-portfolio-2").select("div.av_table_col.portfolio-grid-image").select("img")
                
                for element in secondLinkImages.array() {
                    self.nowImageArray.append(try element.attr("src"))
                    print("image 2 : ", try element.attr("src"))
                }
                
                let secondLinkNext: Elements = try doc.select("div#av-sc-portfolio-2").select("div.av_table_col.portfolio-grid-image").select("a")
                
                for element in secondLinkNext.array() {
                    self.nowNextArray.append(try element.attr("href"))
                    print("Next URL 2 : ", try element.attr("href"))
                }
                
                completion()
                
            } catch let error {
                print("Error: ", error)
            }
    }
    
    func fetchHTMLParsingResultNow(completion: @escaping () -> ()) {
        let urlAddress = "https://www.institutfrancais-seoul.com/ko/2017-%eb%ac%b8%ed%99%94-%ea%b5%90%ec%9c%a1-%ea%b3%bc%ed%95%99-%eb%89%b4%ec%8a%a4/"
        
        guard let url = URL(string: urlAddress) else { return }
            do {
                let html = try String(contentsOf: url, encoding: .utf8)
                let doc: Document = try SwiftSoup.parse(html)
                
                let linkTitles: Elements = try doc.select("div#av-sc-portfolio-2").select("div.av_table_col.portfolio-grid-image").select("a")
                
                for element in linkTitles.array() {
                    self.nowTitleArray.append(try element.attr("title"))
                    print("Title 2 : ", try element.attr("title"))
                }
                
                let linkImages: Elements = try doc.select("div#av-sc-portfolio-2").select("div.av_table_col.portfolio-grid-image").select("img")
                
                for element in linkImages.array() {
                    self.nowImageArray.append(try element.attr("src"))
                    print("image 2 : ", try element.attr("src"))
                }
                
                let linkNext: Elements = try doc.select("div#av-sc-portfolio-2").select("div.av_table_col.portfolio-grid-image").select("a")
                
                for element in linkNext.array() {
                    self.nowNextArray.append(try element.attr("href"))
                    print("Next URL 2 : ", try element.attr("href"))
                }
                completion()
                
            } catch let error {
                print("Error: ", error)
            }
    }
    
    
    
    
    
}
