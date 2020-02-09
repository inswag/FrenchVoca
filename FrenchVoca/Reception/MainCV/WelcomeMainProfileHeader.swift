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
            (Constant.identifierTitleFont.lineHeight) +
            (Constant.imageViewHeight) +
            (Constant.examTitleFont.lineHeight) +
            (Constant.divisionLineHeight) +
            (Constant.messageTitleFont.lineHeight * 2)
        return CGSize(width: cellwidth, height: cellHeight)
    }
    
    struct Constant {
        static let totalMargin: CGFloat = 8 + 16 + 8 + 16 + 16 + 16
        static let identifierTitleFont = Tools.font.avenirLight(size: 14)
        static let imageViewHeight: CGFloat = 90
        static let examTitleFont = Tools.font.avenirBook(size: 16)
        static let divisionLineHeight: CGFloat = 1 * 2
        static let messageTitleFont = Tools.font.avenirBook(size: 18)
    }
    
    // MARK:- Properties
    
    weak var delegate: ReceptionHeaderDelegate?
    
    // MARK:- UI Properties
    
    let identifierTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Calendriers d'examens"
        label.textAlignment = .left
        label.font = Tools.font.avenirLight(size: 14)
        label.textColor = Tools.color.mediumBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    lazy var leftImageButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo_flex")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        btn.addTarget(self, action: #selector(actionLeftClick), for: .touchUpInside)
        return btn
    }()
    
    @objc func actionLeftClick() {
        delegate?.leftImageTapped()
    }
    
    lazy var rightImageButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo_delf")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        
//        btn.layer.cornerRadius = 3
//        btn.layer.borderColor = Tools.color.lineDivisionColor.cgColor
//        btn.layer.borderWidth = 1
//        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(actionRightClick), for: .touchUpInside)
        return btn
    }()
    
    @objc func actionRightClick() {
        delegate?.rightImageTapped()
    }

    

    let leftExamTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "2020 FLEX"
        label.textAlignment = .center
        label.font = Tools.font.avenirBook(size: 16)
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    

    let rightExamTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "2020 DELF"
        label.textAlignment = .center
        label.font = Tools.font.avenirBook(size: 16)
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let firstDivisionLineView: UIView = {
            let view = UIView()
            view.backgroundColor = Tools.color.lineDivisionColor
            // 쉐도우 효과 나타나지 않는 문제.
    //        view.layer.borderWidth = 0.5
    //        view.layer.borderColor = Tools.color.frenchBlue.cgColor
    //        view.layer.cornerRadius = 5.0
    //        view.layer.masksToBounds = false
    //        view.layer.shadowColor = UIColor.gray.cgColor
    //        view.layer.shadowOpacity = 0.3
    //        view.layer.shadowOffset = CGSize(width: 1, height: 1)
    //        view.layer.shadowRadius = 4.0
            return view
        }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "French",
                                                       attributes: [NSAttributedString.Key.font: Tools.font.avenirBook(size: 18), NSAttributedString.Key.foregroundColor: Tools.color.frenchBlue])
        attributedText.append(NSAttributedString(string: " Voca",
                                                 attributes: [NSAttributedString.Key.font: Tools.font.avenirBook(size: 18), NSAttributedString.Key.foregroundColor: Tools.color.frenchRed]))
        attributedText.append(NSAttributedString(string: " 에 오신 것을 환영합니다.", attributes: [NSAttributedString.Key.font: Tools.font.appleSDGothicNeoRegular(size: 18), NSAttributedString.Key.foregroundColor: Tools.color.lightBlack]))
        attributedText.append(NSAttributedString(string: "\nBienvenue chez ", attributes: [NSAttributedString.Key.font: Tools.font.avenirBook(size: 18), NSAttributedString.Key.foregroundColor: Tools.color.lightBlack]))
        attributedText.append(NSAttributedString(string: "French",
                                                 attributes: [NSAttributedString.Key.font: Tools.font.avenirBook(size: 18), NSAttributedString.Key.foregroundColor: Tools.color.frenchBlue]))
        attributedText.append(NSAttributedString(string: " Voca",
                                                 attributes: [NSAttributedString.Key.font: Tools.font.avenirBook(size: 18), NSAttributedString.Key.foregroundColor: Tools.color.frenchRed]))
        attributedText.append(NSAttributedString(string: ".",
                                                 attributes: [NSAttributedString.Key.font: Tools.font.avenirBook(size: 18), NSAttributedString.Key.foregroundColor: Tools.color.lightBlack]))
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    

    let secondDivisionLineView: UIView = {
        let view = UIView()
        view.backgroundColor = Tools.color.lineDivisionColor
        return view
    }()
    
    // MARK:- Initialize

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProfileContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- UI Methods
    
    fileprivate func setupProfileContents() {
        
        let imageStackView = UIStackView(arrangedSubviews: [leftImageButton, rightImageButton])
        imageStackView.axis = .horizontal
        imageStackView.spacing = 8
        imageStackView.distribution = .fillEqually
        
        let textStackView = UIStackView(arrangedSubviews: [leftExamTitleLabel, rightExamTitleLabel])
        textStackView.axis = .horizontal
        textStackView.spacing = 8
        textStackView.distribution = .fillEqually
        
        [identifierTitleLabel,
         imageStackView,
         textStackView,
         messageLabel,
         firstDivisionLineView,
         secondDivisionLineView].forEach {
            self.contentView.addSubview($0)
        }
        
        
        identifierTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)            // FontSize + 10
            $0.leading.equalToSuperview().offset(20)
        }
        
        imageStackView.snp.makeConstraints {
            $0.top.equalTo(identifierTitleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(90)
        }
        
        textStackView.snp.makeConstraints {
            $0.top.equalTo(imageStackView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(15)
        }
        
        firstDivisionLineView.snp.makeConstraints {
            $0.top.equalTo(textStackView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(1)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(firstDivisionLineView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        secondDivisionLineView.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
                
        // Here is AutoLayout of Welcome Header By using 'Anchor'
        // Profile, Username, Position, Welcome Message
//        self.identifierTitleLabel.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        self.profileImageView.anchor(top: self.identifierTitleLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 120, height: 120)
//        self.profileImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
//        self.profileImageView.layer.cornerRadius = 120 / 2
//        self.profileImageView.clipsToBounds = true // Margin : (20 + 20 + 20 + 20 + 20 + 20) = 120
//
//        self.usernameLabel.anchor(top: self.profileImageView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
//        self.positionLabel.anchor(top: self.usernameLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
//
        // Division Line & Welcome Message
//        self.firstDivisionLineView.anchor(top: self.positionLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 1)
//
//        self.messageLabel.anchor(top: self.firstDivisionLineView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
//
//        self.secondDivisionLineView.anchor(top: self.messageLabel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 1)
        
    }
    
    
    
}
