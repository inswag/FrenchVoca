//
//  WordListCommonHeader.swift
//  FrenchVoca
//
//  Created by 박인수 on 10/02/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

//protocol WordListCommonHeaderDelegate: class {
//    func popWordListVC(headerView: UICollectionReusableView)
//}

class WordListCommonHeader: UICollectionViewCell {
    
//    weak var delegate: WordListCommonHeaderDelegate?
    
    static func defineCellSize(cellwidth: CGFloat) -> CGSize {
        let cellHeight = (Constant.backgroundImageHeight)
        return CGSize(width: cellwidth, height: cellHeight)
    }
    
    struct Constant {
        static let backgroundImageHeight: CGFloat = 260
        static let headerTitleFont = Tools.font.appleSDGothicNeoBold(size: 25)
        static let headerSubtitleFont = UIFont(name: "Avenir-Medium", size: 18)
        static let headersubSentenceFont = Tools.font.avenirLight(size: 18)
    }
    
    let menuImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "vocabulaire_Débutant_HeaderImage")
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let koreanTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "주제"
        label.textAlignment = .left
        label.font = Constant.headerTitleFont
        label.textColor = UIColor.rgb(r: 255, g: 255, b: 255)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let subFrenchTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sujet français"
        label.textAlignment = .left
        label.font = Constant.headerSubtitleFont
        label.textColor = UIColor.rgb(r: 255, g: 255, b: 255)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let subSentenceLabel: UILabel = {
        let label = UILabel()
        label.text = "Citation / Proverbe française"
        label.textAlignment = .left
        label.font = Constant.headersubSentenceFont
        label.textColor = UIColor.rgb(r: 255, g: 255, b: 255)
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIComponents()
    }
    
    fileprivate func setupUIComponents() {
        [menuImageView].forEach { self.contentView.addSubview($0) }
        [koreanTitleLabel, subFrenchTitleLabel, subSentenceLabel].forEach { self.menuImageView.addSubview($0) }
        
        // Here is AutoLayout of Vocabulary Menu Header By using 'Anchor'
        // menuImageView, koreanTitleLabel, subFrenchTitleLabel
        self.menuImageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: self.contentView.frame.width, height: 260)
        self.menuImageView.clipsToBounds = true
        
        self.koreanTitleLabel.anchor(top: nil, left: self.menuImageView.leftAnchor, bottom: self.subFrenchTitleLabel.topAnchor, right: self.menuImageView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        self.subFrenchTitleLabel.anchor(top: nil, left: self.menuImageView.leftAnchor, bottom: self.subSentenceLabel.topAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        self.subSentenceLabel.anchor(top: nil, left: self.menuImageView.leftAnchor, bottom: self.menuImageView.bottomAnchor, right: self.menuImageView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


