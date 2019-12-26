//
//  Font.swift
//  FrenchVoca
//
//  Created by 박인수 on 26/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

struct Font {
    
    // Tools.font.systemFont(size: <#입력#>)
    func systemFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    // Tools.font.avenirLight(size: <#입력#>)
    func avenirLight(size: CGFloat) -> UIFont {
        return UIFont.init(name: "Avenir-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    // Tools.font.avenirBlack(size: <#입력#>)
    func avenirBlack(size: CGFloat) -> UIFont {
        return UIFont.init(name: "Avenir-Black", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    // Tools.font.avenirBook(size: <#입력#>)
    func avenirBook(size: CGFloat) -> UIFont {
        return UIFont.init(name: "Avenir-Book", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
}
