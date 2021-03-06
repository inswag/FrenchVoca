//
//  VocabularySubjectListVC.swift
//  FrenchVoca
//
//  Created by 박인수 on 06/02/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class VocabularySubjectListVC: UIViewController {
    
    struct Constant {
        static let totalMargin: CGFloat = 90
        static let vocabularyHeaderUsernameFont = Tools.font.avenirBlack(size: 25)
        static let vocabularyHeaderDivisionLineHeight: CGFloat = 2
    }
    
    // MARK:- Properties
    
    let navigate: Navigator
    
    // MARK:- DAO
    
    var subjectList: [SubjectVO]!
    let subjectDAO = SubjectDAO()
    
    // MARK:- UI Properties
    
    let frenchVocaLogo: UILabel = {
        let label = UILabel()
        label.text = "Bienvenue"
        label.textAlignment = .center
        label.font = Tools.font.avenirBook(size: 20)
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        return label
    }()
    
    
//    lazy var barBtnYours = UIBarButtonItem(image: UIImage(named: "notebook")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(yoursBtnAction))
//    @objc func yoursBtnAction() {
//        print("push your list of vocabulary controller !")
//        self.navigationController?.pushViewController(VocabularyNotebookVC(), animated: true)
//    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.setCollectionViewLayout(layout, animated: true)
        cv.dataSource = self
        cv.delegate = self
        cv.register(VocabularySubjectListHeader.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: String(describing: VocabularySubjectListHeader.self))
        cv.register(VocabularyVocaCell.self, forCellWithReuseIdentifier: String(describing: VocabularyVocaCell.self))
        return cv
    }()

    // MARK:- Initialize
    
    init(navigator: Navigator) {
        self.navigate = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIComponents()
        setupCustomNaviBarDesign()
//        setupAnimation()
        fetchSubjectList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        
        print("view will appear")

    }
    
    // MARK:- Methods
    
    fileprivate func fetchSubjectList() {
        self.subjectList = self.subjectDAO.find()
    }
    
    // MARK:- UI Methods
   
//    fileprivate func setupAnimation() {
//        UIView.animate(withDuration: 2, delay: 0, options: [.autoreverse, .repeat, .transitionCrossDissolve], animations: {
//            self.frenchVocaLogo.alpha = 0.0
//        }, completion: nil)
//    }
    
    fileprivate func setupUIComponents() {
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        print("setupUIComponents loaded")
    }
    
    fileprivate func setupCustomNaviBarDesign() {
//        barBtnYours.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Avenir-Black", size: 20)!, NSAttributedString.Key.foregroundColor: Tools.color.lightBlack], for: .normal)
        
        self.navigationItem.titleView = frenchVocaLogo
        
//        self.navigationItem.rightBarButtonItems = [barBtnYours]
//        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
//        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
}


//MARK:- CV Data Source Methods
extension VocabularySubjectListVC: UICollectionViewDataSource {
    
    // Handle Collection View Cell
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.subjectList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let rowData = self.subjectList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: VocabularyVocaCell.self), for: indexPath) as! VocabularyVocaCell
        cell.koreanTitle.text = rowData.subjectKoreanTitle
        cell.frenchTitle.text = rowData.subjectFrenchTitle
        cell.imageView.image = UIImage(named: "\(rowData.subjectPhoto)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let navigator = Navigator()
//        let wordListVC = WordListViewController(navigator: navigator)
//        wordListVC.indexPath = (indexPath.row + 1)
        self.navigationController?.pushViewController(navigate.get(segue: .wordList(id: indexPath.row + 1)), animated: true)
    }
    
    // Handle Collection View Header
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: VocabularySubjectListHeader.self), for: indexPath) as! VocabularySubjectListHeader
        return header
    }
    
}

//MARK:- CV Delegate Flow Layout Methods
extension VocabularySubjectListVC: UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // Section 의 사이즈는 균일하기 때문에 굳이 스위치문으로 나눌 필요가 없다.
        return VocabularySubjectListHeader.defineCellSize(cellwidth: self.view.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 각 셀의 크기는 균일할 것이기 때문에 굳이 스위치문으로 나눌 필요가 없다. 후에 각 셀의 크기를 다르게 지정해 줄 때에는 나눔.
        return VocabularyVocaCell.defineCellSize(cellwidth: self.view.frame.width)
    }
    
}
