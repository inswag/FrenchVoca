//
//  Color.swift
//  FrenchVoca
//
//  Created by 박인수 on 26/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(r red: CGFloat, g green: CGFloat, b blue: CGFloat, a alpha: CGFloat = 1.0) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}

struct Color {
    
    // Tools.color.lightBlack
    var lightBlack: UIColor {
        return UIColor.rgb(r: 74, g: 74, b: 74)
    }
    
    // Tools.color.prettyBlack
    var prettyBlack: UIColor {
        return UIColor.rgb(r: 54, g: 54, b: 54)
    }
    
    // Tools.color.mediumBlack
    var mediumBlack: UIColor {
        return UIColor.rgb(r: 138, g: 137, b: 137)
    }
    
    // Tools.color.lightGray
    var lightGray: UIColor {
        return UIColor.rgb(r: 246, g: 246, b: 250)
    }
    
    // Tools.color.prettyGray
    var prettyGray: UIColor {
        return UIColor.rgb(r: 155, g: 155, b: 155)
    }
    
    // Tools.color.mediumGray
    var mediumGray: UIColor {
        return UIColor.rgb(r: 163, g: 163, b: 181)
    }
    
    // Tools.color.darkGray
    var darkGray: UIColor {
        return UIColor.rgb(r: 199, g: 203, b: 210)
    }
    
    // Tools.color.frenchBlue
    var frenchBlue: UIColor {
        return UIColor.rgb(r: 36, g: 74, b: 156)
    }
    
    // Tools.color.frenchRed
    var frenchRed: UIColor {
        return UIColor.rgb(r: 223, g: 39, b: 39)
    }
    
    // Tools.color.lineDivisionColor
    var lineDivisionColor: UIColor {
        return UIColor.rgb(r: 225, g: 225, b: 225)
    }
    
    // Tools.color.sandYellow
    var sandYellow: UIColor {
        return UIColor.rgb(r: 232, g: 220, b: 180)
    }
    
    // SignIn -> student card
    var cardBlue: UIColor {
        return UIColor.rgb(r: 29, g: 78, b: 156)
    }
}
