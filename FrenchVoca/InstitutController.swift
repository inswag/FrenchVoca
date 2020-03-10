//
//  InstitutController.swift
//  FrenchVoca
//
//  Created by Insu Park on 2020/03/10.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit
import Kanna

class InstitutController: UIViewController {

    let url = "https://www.institutfrancais-seoul.com/ko/2017-%eb%ac%b8%ed%99%94-%ea%b5%90%ec%9c%a1-%ea%b3%bc%ed%95%99-%eb%89%b4%ec%8a%a4/"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: self.url) else { return }
        
        
        do {
            let html = try String(contentsOf: url, encoding: .utf8) // URL에 해당하는 모든 HTML 을 가져옴
            let doc = try HTML(html: html, encoding: .utf8)
            
            for product in doc.xpath("//div[@class='av_table_col portfolio-grid-image']") {
                print(product)
                if let productUrl = product.at_xpath("a") {
                    if let title = productUrl.text {
                        print(title)
                    }
                }
            }
            
//            print(html)
//            print(doc)
         
            
            
        } catch let error {
            print("Error: \(error)")
        }
        // Do any additional setup after loading the view.
    }


}
