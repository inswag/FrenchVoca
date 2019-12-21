//
//  WelcomeMainWordCell.swift
//  FrenchVoca
//
//  Created by 박인수 on 11/04/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class WelcomeMainWordCell: UICollectionViewCell {
    
    // Word exemple
    let wordDAO = WordDAO()
    var wordVO: [WordVO]!
    var fiveWordsVO: WordVO!
    
    static func defineCellSize(cellwidth: CGFloat) -> CGSize {
        let margin: CGFloat = 44 + 10 // 2(Border) + 10(top ~ title)
        let cvHeight = (Constant.wordCellTitleFont!.lineHeight) + (Constant.wordCellSubTitleFont!.lineHeight) + (WelcomeMainWordNestedCell.Constant.containerViewHeight)
            // 컬렉션 뷰의 높이를 가져와야 한다.
        let totalHeight = margin + cvHeight
        return CGSize(width: cellwidth, height: totalHeight)
    }
    
    struct Constant {
        static let collectionViewHeight: CGFloat = 200 // 228
        static let wordCellTitleFont = UIFont(name: "Avenir-Light", size: 14)
        static let wordCellSubTitleFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
    }
    
    
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
        cv.register(WelcomeMainWordNestedCell.self, forCellWithReuseIdentifier: String(describing: WelcomeMainWordNestedCell.self))
        // Anchor 는 클로저 바깥에서 잡아주어야 한다.
        return cv
    }()
    
    let wordTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "5 Mots aléatoires"
        label.textAlignment = .left
        label.font = Constant.wordCellTitleFont
        label.textColor = UIColor.rgb(red: 138, green: 137, blue: 137)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wordSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "프렌치 보카의 5개의 단어를 미리 만나보세요!"
        label.textAlignment = .left
        label.font = Constant.wordCellSubTitleFont
        label.textColor = UIColor.rgb(red: 73, green: 72, blue: 72)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellPhraseContents()
        
        self.wordVO = self.wordDAO.findForFiveWords()
        
        findFiveWords()
        
    }
    
    var numArray: [Int] = []
    
    fileprivate func findFiveWords() {
        let totalWordNumber = UInt32(self.wordVO.count)
        for _ in 1...5 {
            let randomNum = Int(arc4random_uniform(totalWordNumber))
            numArray += [randomNum]
        }

    }
    
    
    fileprivate func setupCellPhraseContents() {
        [wordTitleLabel, wordSubtitleLabel, collectionView].forEach { self.contentView.addSubview($0) }
        collectionView.backgroundColor = .white
        wordTitleLabel.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: nil, right: self.contentView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        wordSubtitleLabel.anchor(top: self.wordTitleLabel.bottomAnchor, left: self.contentView.leftAnchor, bottom: nil, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
//        let plist = UserDefaults.standard
//        let username = plist.string(forKey: "이름")
//        wordSubtitleLabel.text = "French Voca의 5개의 단어를 만나보세요!"
        
        collectionView.anchor(top: self.wordSubtitleLabel.bottomAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WelcomeMainWordCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WelcomeMainWordNestedCell.self), for: indexPath) as! WelcomeMainWordNestedCell
        
        let selectedNum = self.numArray[indexPath.row]
        
        self.fiveWordsVO = self.wordVO[selectedNum]
        cell.wordFrenchLabel.text = self.fiveWordsVO.wordTitle
        cell.wordPartOfSpeechLabel.text = self.fiveWordsVO.wordPartOfSpeech
        cell.wordGenderLabel.text = self.fiveWordsVO.wordGender
        cell.wordNumberLabel.text = self.fiveWordsVO.wordNumber
        cell.wordMeaningLabel.text = self.fiveWordsVO.wordMeaning
//        cell.wordFrenchExampleLabel.text = self.fiveWordsVO.wordFrenchExam
//        cell.wordKoreanExampleLabel.text = self.fiveWordsVO.wordKoreanExam
        
        return cell
    }
    
}


extension WelcomeMainWordCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return WelcomeMainWordNestedCell.defineCellSize(cellwidth: self.contentView.frame.width - 65)
        // 65 = Left Margin 25 + Right Margin 25 + cell Distance 20
    }
}
