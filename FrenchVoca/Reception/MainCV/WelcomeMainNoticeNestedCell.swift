//
//  WelcomeMainNoticeNestedCell.swift
//  FrenchVoca
//
//  Created by 박인수 on 01/04/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class WelcomeMainNoticeNestedCell: UICollectionViewCell {
    
    static func defineCellSize(cellwidth: CGFloat) -> CGSize {
        let cellHeight = (Constant.totalMargin) +
            (Constant.imageViewHeight) +
            (Constant.titleFont.lineHeight) +
            (Constant.subTitleFont.lineHeight)
        return CGSize(width: cellwidth, height: cellHeight)
    }
    
    struct Constant {
        static let totalMargin: CGFloat = 5
        static let imageViewHeight: CGFloat = 150  // Border 를 프로그래밍으로 주는게 좋을까 디자인에서 주는게 좋을까?
        static let titleFont = Tools.font.avenirLight(size: 15)
        static let subTitleFont = Tools.font.appleSDGothicNeoBold(size: 11)
    }
    
    
    let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "Annonces_words")
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = false
        return imgView
    }()
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Touchez pour voir le calendrier des examens."
        label.font = Constant.titleFont
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "버튼을 터치하여 시험 일정을 확인하세요."
        label.font = Constant.subTitleFont
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIDesign()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUIDesign() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(subTitleLabel)
        // 상하좌우 Margin 은 inset 을 통해 구현.
        self.imageView.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: nil, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: (self.contentView.frame.width), height: 150)
        
        self.imageView.layer.borderWidth = 1.0
        self.imageView.layer.borderColor = Tools.color.lineDivisionColor.cgColor
        self.imageView.layer.cornerRadius = 10.0
        self.imageView.layer.masksToBounds = true
        
        self.titleLabel.anchor(top: self.imageView.bottomAnchor, left: self.contentView.leftAnchor, bottom: nil, right: self.contentView.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        self.subTitleLabel.anchor(top: self.titleLabel.bottomAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        

        print("OK")
    }
    
}
