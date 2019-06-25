//
//  Extensions.swift
//  FrenchVocaSecondVersion
//
//  Created by 박인수 on 21/01/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit


extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

// NSLayoutConstraint 를 extension 을 활용하여 function 을 만든 후 재사용을 통해 쉽게 오토레이아웃을 잡을 수 있게 해주었다.
extension UIView {
    
    // stackView.topAnchor 와 stackView.bottomAnchor 의 타입은 'NSLayoutYAxisAnchor' 이며,
    // stackView.leftAnchor 와 stackView.rightAnchor 의 타입은 'NSLayoutXAxisAnchor' 이다.
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        // .translatesAutoresizingMaskIntoConstraints :
        // A Boolean value that determines whether the view’s autoresizing mask is translated into Auto Layout constraints.
        // autoresizing mask : An integer bit mask that determines how the receiver resizes itself when its superview’s bounds change.
        // 쉽게, AutoLayout 을 동적으로 주고 싶을 때 'false'
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

