//
//  WelcomeMainNoticeCell.swift
//  FrenchVocaSecondVersion
//
//  Created by 박인수 on 23/01/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class WelcomeMainNoticeCell: UICollectionViewCell {
    
    static func defineCellSize(cellwidth: CGFloat) -> CGSize {
        let margin: CGFloat = 44 + 10 // 2(Border) + 10(top ~ title)
        let cvHeight = (Constant.noticeCellTitleFont!.lineHeight) +
            (WelcomeMainNoticeNestedCell.Constant.imageViewHeight) +
            (WelcomeMainNoticeNestedCell.Constant.titleFont!.lineHeight) +
            (WelcomeMainNoticeNestedCell.Constant.subTitleFont!.lineHeight) +
            (WelcomeMainNoticeNestedCell.Constant.totalMargin)
        let totalHeight = margin + cvHeight
        return CGSize(width: cellwidth, height: totalHeight)
    }
    
    struct Constant {
        static let collectionViewHeight: CGFloat = 200 // 228
//        static let totalMargin: CGFloat = 73 // 약간의 마진때문에 구분선이 사라져서 +3 추가
        static let noticeCellTitleFont = UIFont(name: "Avenir-Light", size: 14)
//        static let NoticeCellFrenchContentFont = UIFont(name: "Avenir-Book", size: 16)
//        static let NoticeCellKoreanContentFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
    }
    
    let title = ["24 sujets, environ 900 mots et exemples.",
                 "Touchez ces boutons pour voir le calendrier des examens."]
    let subTitle = ["24개의 주제, 약 900개의 단어와 예문을 지원합니다.",
                           "버튼을 터치하여 시험 일정을 확인할 수 있어요."]
    let image = ["Annonces_words", "Annonces_examens"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: CGRect.zero , collectionViewLayout: layout)
        cv.setCollectionViewLayout(layout, animated: true)
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        cv.register(WelcomeMainNoticeNestedCell.self, forCellWithReuseIdentifier: String(describing: WelcomeMainNoticeNestedCell.self))
        // Anchor 는 클로저 바깥에서 잡아주어야 한다.
        return cv
    }()
    
    let noticeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Annonces"
        label.textAlignment = .left
        label.font = Constant.noticeCellTitleFont
        label.textColor = UIColor.rgb(red: 138, green: 137, blue: 137)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellPhraseContents()
        
    }
    
    fileprivate func setupCellPhraseContents() {
        [noticeTitleLabel, collectionView].forEach { self.contentView.addSubview($0) }
        collectionView.backgroundColor = .white
        noticeTitleLabel.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        collectionView.anchor(top: self.noticeTitleLabel.bottomAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WelcomeMainNoticeCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WelcomeMainNoticeNestedCell.self), for: indexPath) as! WelcomeMainNoticeNestedCell
        
        cell.titleLabel.text = self.title[indexPath.row]
        cell.subTitleLabel.text = self.subTitle[indexPath.row]
        cell.imageView.image = UIImage(named: self.image[indexPath.row])
        
        return cell
    }
    
}


extension WelcomeMainNoticeCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return WelcomeMainNoticeNestedCell.defineCellSize(cellwidth: self.contentView.frame.width - 65)
        // 65 = Left Margin 25 + Right Margin 25 + cell Distance 20
    }
}
