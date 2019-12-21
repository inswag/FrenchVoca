//
//  WelcomeMainHeader.swift
//  FrenchVocaSecondVersion
//
//  Created by 박인수 on 23/01/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class WelcomeMainProfileHeader: UICollectionViewCell {
    
    // Student Card + Welcome Message PART
    static func defineCellSize(cellwidth: CGFloat) -> CGSize {
        let cellHeight = (Constant.totalMargin) +
            (Constant.profileHeaderIdentifierTitleFont!.lineHeight) +
            (Constant.profileImageHeight) +
            (Constant.profileHeaderUsernameFont!.lineHeight) +
            (Constant.profileHeaderPositionFont!.lineHeight) +
            (Constant.profileHeaderFirstLineMessageFont!.lineHeight) +
            (Constant.profileHeaderSecondLineMessageFont!.lineHeight) +
            (Constant.welcomeHeaderDivisionLineHeight * 2)
        return CGSize(width: cellwidth, height: cellHeight)
    }
    
    struct Constant {
        static let profileImageHeight: CGFloat = 120
        static let totalMargin: CGFloat = 110 + 10 // 10 : 최상단 ~ 타이틀 마진
        static let profileHeaderIdentifierTitleFont = UIFont(name: "Avenir-Light", size: 14)
        static let profileHeaderUsernameFont = UIFont(name: "Avenir-Black", size: 25)
        static let profileHeaderPositionFont = UIFont(name: "Avenir-Book", size: 20)
        static let profileHeaderFirstLineMessageFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        static let profileHeaderSecondLineMessageFont = UIFont(name: "Avenir-Book", size: 18)
        static let welcomeHeaderDivisionLineHeight: CGFloat = 1 * 2
    }
    
    let identifierTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Carte d'étudiant"
        label.textAlignment = .left
        label.font = Constant.profileHeaderIdentifierTitleFont
        label.textColor = UIColor.rgb(red: 138, green: 137, blue: 137)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "VOTRE SURNOM"
        label.textAlignment = .center
        label.font = Constant.profileHeaderUsernameFont
        label.textColor = UIColor.rgb(red: 74, green: 74, blue: 74)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let positionLabel: UILabel = {
        let label = UILabel()
        label.text = "Votre position"
        label.textAlignment = .center
        label.font = Constant.profileHeaderPositionFont
        label.textColor = UIColor.rgb(red: 74, green: 74, blue: 74)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "French",
                                                       attributes: [NSAttributedString.Key.font: Constant.profileHeaderSecondLineMessageFont!, NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 36, green: 74, blue: 156)])
        attributedText.append(NSAttributedString(string: " Voca",
                                                 attributes: [NSAttributedString.Key.font: Constant.profileHeaderSecondLineMessageFont!, NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 232, green: 0, blue: 0)]))
        attributedText.append(NSAttributedString(string: " 에 오신 것을 환영합니다.", attributes: [NSAttributedString.Key.font: Constant.profileHeaderFirstLineMessageFont!, NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 74, green: 74, blue: 74)]))
        attributedText.append(NSAttributedString(string: "\nBienvenue chez ", attributes: [NSAttributedString.Key.font: Constant.profileHeaderSecondLineMessageFont!, NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 74, green: 74, blue: 74)]))
        attributedText.append(NSAttributedString(string: "French",
                                                 attributes: [NSAttributedString.Key.font: Constant.profileHeaderSecondLineMessageFont!, NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 36, green: 74, blue: 156)]))
        attributedText.append(NSAttributedString(string: " Voca",
                                                 attributes: [NSAttributedString.Key.font: Constant.profileHeaderSecondLineMessageFont!, NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 232, green: 0, blue: 0)]))
        attributedText.append(NSAttributedString(string: ".",
                                                 attributes: [NSAttributedString.Key.font: Constant.profileHeaderSecondLineMessageFont!, NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 74, green: 74, blue: 74)]))
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let firstDivisionLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 225, green: 225, blue: 225)
        // 쉐도우 효과 나타나지 않는 문제.
//        view.layer.borderWidth = 0.5
//        view.layer.borderColor = UIColor.rgb(red: 36, green: 74, blue: 156).cgColor
//        view.layer.cornerRadius = 5.0
//        view.layer.masksToBounds = false
//        view.layer.shadowColor = UIColor.gray.cgColor
//        view.layer.shadowOpacity = 0.3
//        view.layer.shadowOffset = CGSize(width: 1, height: 1)
//        view.layer.shadowRadius = 4.0
        return view
    }()

    let secondDivisionLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 225, green: 225, blue: 225)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProfileContents()
    }
    
    fileprivate func setupProfileContents() {
        [identifierTitleLabel, profileImageView, usernameLabel, positionLabel, messageLabel, firstDivisionLineView, secondDivisionLineView].forEach { self.contentView.addSubview($0) }
        
        // Here is AutoLayout of Welcome Header By using 'Anchor'
        // Profile, Username, Position, Welcome Message
        self.identifierTitleLabel.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        self.profileImageView.anchor(top: self.identifierTitleLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 120, height: 120)
        self.profileImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.profileImageView.layer.cornerRadius = 120 / 2
        self.profileImageView.clipsToBounds = true // Margin : (20 + 20 + 20 + 20 + 20 + 20) = 120
        
        self.usernameLabel.anchor(top: self.profileImageView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        self.positionLabel.anchor(top: self.usernameLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        // Division Line & Welcome Message
        self.firstDivisionLineView.anchor(top: self.positionLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 1)
        
        self.messageLabel.anchor(top: self.firstDivisionLineView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        self.secondDivisionLineView.anchor(top: self.messageLabel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 1)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
