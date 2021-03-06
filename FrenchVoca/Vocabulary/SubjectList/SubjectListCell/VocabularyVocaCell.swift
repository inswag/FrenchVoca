//
//  VocabularyVocaCell.swift
//  FrenchVoca
//
//  Created by 박인수 on 19/03/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class VocabularyVocaCell: UICollectionViewCell {
    
    static func defineCellSize(cellwidth: CGFloat) -> CGSize {
        let cellHeight = (Constant.imageViewHeight)
        return CGSize(width: cellwidth, height: cellHeight)
    }
    
    struct Constant {
        static let imageViewHeight: CGFloat = 50
        static let totalMargin: CGFloat = 20
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
//        iv.backgroundColor = UIColor.rgb(red: 251, green: 132, blue: 132)
        return iv
    }()
    
    let koreanTitle: UILabel = {
        let label = UILabel()
        label.text = "주제이름"
        label.font = Tools.font.appleSDGothicNeoRegular(size: 12)
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
        
    }()
    
    let frenchTitle: UILabel = {
        let label = UILabel()
        label.text = "Nom de Sujet"
        label.font = Tools.font.avenirLight(size: 12)
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label

    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIComponents()
    }
    
    fileprivate func setupUIComponents() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(koreanTitle)
        self.contentView.addSubview(frenchTitle)
        
        self.imageView.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: 120, height: 50)
        self.koreanTitle.anchor(top: nil, left: self.imageView.rightAnchor, bottom: nil, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        self.koreanTitle.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor, constant: -(koreanTitle.font.lineHeight) + 5).isActive = true
        
        self.frenchTitle.anchor(top: nil, left: self.imageView.rightAnchor, bottom: nil, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        self.frenchTitle.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor, constant: (frenchTitle.font.lineHeight) - 5).isActive = true
        
        self.imageView.layer.cornerRadius = 3.0
        self.imageView.layer.masksToBounds = true
        print("OK")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

