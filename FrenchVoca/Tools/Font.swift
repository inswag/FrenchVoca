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
    
    // Tools.font.avenirMedium(size: <#입력#>)
    func avenirMedium(size: CGFloat) -> UIFont {
        return UIFont.init(name: "Avenir-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    // Tools.font.appleSDGothicNeoRegular(size: <#입력#>)
    func appleSDGothicNeoRegular(size: CGFloat) -> UIFont {
        return UIFont.init(name: "AppleSDGothicNeo-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    // Tools.font.appleSDGothicNeoBold(size: <#입력#>)
    func appleSDGothicNeoBold(size: CGFloat) -> UIFont {
        return UIFont.init(name: "AppleSDGothicNeo-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    // Tools.font.lucidaGrandeRegular(size: <#입력#>)
    func lucidaGrandeRegular(size: CGFloat) -> UIFont {
        return UIFont.init(name: "LucidaGrande-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
