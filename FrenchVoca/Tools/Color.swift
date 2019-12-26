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
    
    // Tools.color.mediumBlack
    var mediumBlack: UIColor {
        return UIColor.rgb(r: 138, g: 137, b: 137)
    }
    
    // Tools.color.darkGray
    var darkGray: UIColor {
        return UIColor.rgb(r: 199, g: 203, b: 210)
    }
    
    // Tools.color.mediumGray
    var mediumGray: UIColor {
        return UIColor.rgb(r: 163, g: 163, b: 181)
    }
    
    // Tools.color.lightGray
    var lightGray: UIColor {
        return UIColor.rgb(r: 246, g: 246, b: 250)
    }
    
    // Tools.color.frenchBlue
    var frenchBlue: UIColor {
        return UIColor.rgb(r: 36, g: 74, b: 156)
    }
    
    
    
    
    // MARK:- Enrollment
    var enrollmentTitle: UIColor {
        return UIColor.black
    }
    
    var formValid: UIColor {
        return UIColor.rgb(r: 36, g: 74, b: 156)
    }
    
    var formInvalid: UIColor {
        return UIColor.rgb(r: 199, g: 203, b: 210)
    }
    
    var descriptionBackground: UIColor {
        return UIColor.rgb(r: 246, g: 246, b: 250)
    }
    
    var descriptionTitle: UIColor {
        return UIColor.rgb(r: 163, g: 163, b: 181)
    }
    
    // MARK:- Sign In
    var verificationTitle: UIColor {
        return UIColor.black
    }
    
    var backButton: UIColor {
        return UIColor.rgb(r: 74, g: 74, b: 74)
    }
    
    var containerBorder: UIColor {
        return UIColor.rgb(r: 138, g: 137, b: 137)
    }
    
    
    
    var studentUsername: UIColor {
        return UIColor.rgb(r: 74, g: 74, b: 74)
    }
    
    var studentPosition: UIColor {
        return UIColor.rgb(r: 74, g: 74, b: 74)
    }
    
    var saveValid: UIColor {
        return UIColor.rgb(r: 36, g: 74, b: 156)
    }
    
    var saveInvalid: UIColor {
        return UIColor.rgb(r: 199, g: 203, b: 210)
    }
    
    
    
}
