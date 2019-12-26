//
//  SettingPeopleCell.swift
//  FrenchVoca
//
//  Created by 박인수 on 20/04/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class SettingPeopleCell: UICollectionViewCell {
    
//    static func defineCellSize(cellwidth: CGFloat) -> CGSize {
//        let margin: CGFloat = 44 + 10 // 2(Border) + 10(top ~ title)
//        let cvHeight = (Constant.noticeCellTitleFont!.lineHeight) + (Constant.noticeCellSubTitleFont!.lineHeight) +
//            (WelcomeMainNoticeNestedCell.Constant.imageViewHeight) +
//            (WelcomeMainNoticeNestedCell.Constant.titleFont!.lineHeight) +
//            (WelcomeMainNoticeNestedCell.Constant.subTitleFont!.lineHeight) +
//            (WelcomeMainNoticeNestedCell.Constant.totalMargin)
//        let totalHeight = margin + cvHeight
//        return CGSize(width: cellwidth, height: totalHeight)
//    }
//
    struct Constant {
        static let margin: CGFloat = 30
         // 228
        static let peopleNameFont = Tools.font.avenirLight(size: 14)
        static let peoplePositionFont = Tools.font.avenirBook(size: 12)

    }
//
//    let title = ["24 sujets, environ 900 mots et exemples.",
//                 "Touchez ces boutons pour voir le calendrier des examens."]
//    let subTitle = ["24개의 주제, 약 900개의 단어와 예문을 지원합니다.",
//                    "화면 맨 위의 버튼을 터치하여 시험 일정을 확인할 수 있어요."]
//    let image = ["Annonces_words", "Annonces_examens"]
//
    let profileImage: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .darkGray
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()

    let peopleNameLabel: UILabel = {
        let label = UILabel()
        label.text = "inswag_"
        label.textAlignment = .center
        label.font = Constant.peopleNameFont
        label.textColor = Tools.color.mediumBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        return label
    }()

    let peoplePositionLabel: UILabel = {
        let label = UILabel()
        label.text = "Développeur"
        label.textAlignment = .center
        label.font = Constant.peoplePositionFont
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellPhraseContents()
        
    }

    fileprivate func setupCellPhraseContents() {
        [profileImage, peopleNameLabel, peoplePositionLabel].forEach { self.contentView.addSubview($0) }

        self.profileImage.anchor(top: self.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: self.contentView.frame.width - 20, height: self.contentView.frame.width - 20)
        self.profileImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.profileImage.layer.cornerRadius = (self.contentView.frame.width - 20) / 2
        
        
        self.peopleNameLabel.anchor(top: self.profileImage.bottomAnchor, left: self.contentView.leftAnchor, bottom: nil, right: self.contentView.rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)

        self.peoplePositionLabel.anchor(top: self.peopleNameLabel.bottomAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 10, paddingRight: 5, width: 0, height: 0)
        // margin(Bottom to Top) = 10 + position + name + 10 + profile + 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
