//
//  VocabularyWordListVC.swift
//  FrenchVoca
//
//  Created by 박인수 on 10/02/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class VocabularyWordListVC: UIViewController {
    
//    struct Constant {
//        static let totalMargin: CGFloat = 90
//        static let vocabularyHeaderUsernameFont = UIFont(name: "Avenir-Black", size: 25)
//        static let vocabularyHeaderSuggestionFont = UIFont(name: "Avenir-Book", size: 20)
//        static let vocabularyHeaderDivisionLineHeight: CGFloat = 2
//    }
    
    var wordDAO = WordDAO()
    var subjectDAO = SubjectDAO()
    
    var wordList: [WordVO]!
    var subjectInfo: (subjectCd: Int, subjectKoreanTitle: String, subjectFrenchTitle: String, subjectSentence: String)!
    
    var indexPath: Int = 0
    
    let customNaviBarTitle: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 110, height: 27)) // 1102/27
        let label = UILabel()
        view.addSubview(label)
        label.text = "French Voca"
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Book", size: 20)
        label.textColor = UIColor.rgb(red: 74, green: 74, blue: 74)
        label.numberOfLines = 1
        label.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.setCollectionViewLayout(layout, animated: true)
        cv.dataSource = self
        cv.delegate = self
        cv.register(VocabularyMenuCollectionViewHeader.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: String(describing: VocabularyMenuCollectionViewHeader.self))
        cv.register(VocabularyMenuCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: VocabularyMenuCollectionViewCell.self))
        // Anchor 는 클로저 바깥에서 잡아주어야 한다.
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupUIDesign()
        setupNaviBarDesign()
        
        self.wordList = self.wordDAO.find(subjectCd: indexPath)
        self.subjectInfo = self.subjectDAO.get(subjectCd: indexPath)
    }
    
    fileprivate func setupUIDesign() {
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        print("setupUIDesign loaded")
    }
    
    fileprivate func setupNaviBarDesign() {
        self.navigationItem.titleView = customNaviBarTitle
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
}


extension VocabularyWordListVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Handle Collection View Cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.wordList.count
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 각 셀의 크기는 균일할 것이기 때문에 굳이 스위치문으로 나눌 필요가 없다. 후에 각 셀의 크기를 다르게 지정해 줄 때에는 나눔.
        return CGSize(width: self.view.frame.width, height: 40)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: VocabularyMenuCollectionViewCell.self), for: indexPath) as! VocabularyMenuCollectionViewCell
            cell.backgroundColor = .red
            return cell
        
    }
    
    // Handle Collection View Header
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // Section 의 텍스트는 4번 불리기 때문에 어레이 타입의 배열을 넣어야지 굳이 스위치문으로 나눌 필요가 없다.
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: VocabularyMenuCollectionViewHeader.self), for: indexPath) as! VocabularyMenuCollectionViewHeader
        
        // 아래의 텍스트로는 각 섹션의 타이틀이 들어갈 예정입니다.
        header.koreanTitleLabel.text = self.subjectInfo.subjectKoreanTitle
        header.subFrenchTitleLabel.text = self.subjectInfo.subjectFrenchTitle
        header.subSentenceLabel.text = "\(self.subjectInfo.subjectSentence)"
        header.menuImageView.image = UIImage(named: "\(self.subjectInfo.subjectFrenchTitle)")
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // Section 의 사이즈는 균일하기 때문에 굳이 스위치문으로 나눌 필요가 없다.
        return VocabularyMenuCollectionViewHeader.defineCellSize(cellwidth: self.view.frame.width)
    }
    
}

//extension VocabularyWordListVC: VocabularyWordListHeaderDelegate {
//    func popWordListVC(headerView: UICollectionReusableView) {
//        self.navigationController?.popViewController(animated: true)
//    }
//}
