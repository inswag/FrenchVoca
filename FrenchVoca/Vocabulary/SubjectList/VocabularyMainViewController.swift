//
//  VocabularySubjectVC.swift
//  FrenchVoca
//
//  Created by 박인수 on 06/02/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class VocabularySubjectVC: UIViewController {
    
    struct Constant {
        static let totalMargin: CGFloat = 90
        static let vocabularyHeaderUsernameFont = UIFont(name: "Avenir-Black", size: 25)
        static let vocabularyHeaderSuggestionFont = UIFont(name: "Avenir-Book", size: 20)
        static let vocabularyHeaderDivisionLineHeight: CGFloat = 2
    }
    
    // MARK:- Custom Navigation Bar 
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
        layout.minimumLineSpacing = 10
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.setCollectionViewLayout(layout, animated: true)
        cv.dataSource = self
        cv.delegate = self
        cv.register(VocabularyCollectionViewHeader.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: String(describing: VocabularyCollectionViewHeader.self))
        cv.register(VocabularyCVVocaCell.self, forCellWithReuseIdentifier: String(describing: VocabularyCVVocaCell.self))
        return cv
    }()

    var subjectList: [(subjectCd: Int, subjectKoreanTitle: String, subjectFrenchTitle: String, subjectPhoto: String)]!
    let subjectDAO = SubjectDAO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIDesign()
        setupNaviBarDesign()
        self.subjectList = self.subjectDAO.find()
        
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


extension VocabularySubjectVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Handle Collection View Cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.subjectList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 각 셀의 크기는 균일할 것이기 때문에 굳이 스위치문으로 나눌 필요가 없다. 후에 각 셀의 크기를 다르게 지정해 줄 때에는 나눔.
        return VocabularyCVVocaCell.defineCellSize(cellwidth: self.view.frame.width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let rowData = self.subjectList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: VocabularyCVVocaCell.self), for: indexPath) as! VocabularyCVVocaCell
        cell.levelKoreanTitle.text = rowData.subjectKoreanTitle
        cell.levelFrenchTitle.text = rowData.subjectFrenchTitle
        cell.imageView.image = UIImage(named: "\(rowData.subjectPhoto)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(VocabularyMenuViewController(), animated: true)
        
//        let deta
        
    }
    
    // Handle Collection View Header
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // Section 의 텍스트는 4번 불리기 때문에 어레이 타입의 배열을 넣어야지 굳이 스위치문으로 나눌 필요가 없다.
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: VocabularyCollectionViewHeader.self), for: indexPath) as! VocabularyCollectionViewHeader
        
        // 아래의 텍스트로는 각 섹션의 타이틀이 들어갈 예정입니다.
        
        print("HEADER")
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // Section 의 사이즈는 균일하기 때문에 굳이 스위치문으로 나눌 필요가 없다.
        return VocabularyCollectionViewHeader.defineCellSize(cellwidth: self.view.frame.width)
    }
    
}

