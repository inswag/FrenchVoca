//
//  VocabularyWordListVC.swift
//  FrenchVoca
//
//  Created by 박인수 on 10/02/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import AVFoundation
import UIKit

class VocabularyWordListVC: UIViewController {
    
    
    struct Font {
        static let naviBarTitleFont = Tools.font.avenirBook(size: 20)
    }
    
    // MARK:- DAO Property
    var wordDAO = WordDAO()
    var subjectDAO = SubjectDAO()
    var wordList: [WordVO]!
    var subjectInfo: (subjectCd: Int, subjectKoreanTitle: String, subjectFrenchTitle: String, subjectSentence: String)!
    var indexPath: Int = 0
    
    // MARK:- Navigation Objects
    let customNaviBarTitle: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 110, height: 27)) // 1102/27
        let label = UILabel()
        view.addSubview(label)
        label.text = "French Voca"
        label.textAlignment = .center
        label.font = Font.naviBarTitleFont
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        label.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        return view
    }()
    
    lazy var popImageButton: UIButton = {
        let btn = UIButton()
        let btnImg = "Pop_Black_Button"
        btn.setImage(UIImage(named: btnImg), for: .normal)
        btn.addTarget(self, action: #selector(popAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var popTextButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Arrière", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(popAction), for: .touchUpInside)
        return btn
    }()
    
    @objc func popAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    lazy var optionButton: UIButton = {
       let btn = UIButton()
        let btnImg = "options"
        btn.setImage(UIImage(named: btnImg), for: .normal)
        btn.addTarget(self, action: #selector(actionOption), for: .touchUpInside)
        return btn
    }()
    
    @objc func actionOption() {
        print("action Option !")
        let vocabularyVoiceSettingVC = VocabularyVoiceSettingVC()
        vocabularyVoiceSettingVC.modalPresentationStyle = .pageSheet
        self.present(vocabularyVoiceSettingVC, animated: true, completion: nil)
    }
    
    // MARK:- Collection View(=CV)
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.setCollectionViewLayout(layout, animated: true)
        cv.dataSource = self
        cv.delegate = self
        
        cv.register(VocabularyWordListHeader.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: String(describing: VocabularyWordListHeader.self))
        cv.register(VocabularyWordListCellForSentence.self, forCellWithReuseIdentifier: String(describing: VocabularyWordListCellForSentence.self))
        cv.register(VocabularyWordListCellForPhoto.self, forCellWithReuseIdentifier: String(describing:VocabularyWordListCellForPhoto.self))
        // Anchor 는 클로저 바깥에서 잡아주어야 한다.
        return cv
    }()
    
    // MARK:- View Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupUIDesign()
        setupNaviBarDesign()
        
        self.wordList = self.wordDAO.find(subjectCd: indexPath)
        self.subjectInfo = self.subjectDAO.get(subjectCd: indexPath)
        
        
    }
    
    
    // MARK:- Design
    fileprivate func setupUIDesign() {
        self.navigationController?.navigationBar.isHidden = true
        
        [collectionView].forEach { self.view.addSubview($0) }
        collectionView.backgroundColor = .white
        collectionView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        [popImageButton, popTextButton, optionButton].forEach { self.view.addSubview($0) }

        self.popImageButton.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 12, height: 20.5)
        self.popTextButton.anchor(top: nil, left: self.popImageButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        self.popTextButton.centerYAnchor.constraint(equalTo: self.popImageButton.centerYAnchor).isActive = true
        
        self.optionButton.anchor(top: nil, left: nil, bottom: nil, right: self.view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 35, height: 35)
        self.optionButton.centerYAnchor.constraint(equalTo: self.popImageButton.centerYAnchor).isActive = true
    }
    
    fileprivate func setupNaviBarDesign() {
//        self.navigationItem.titleView = customNaviBarTitle
//        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
//        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    
    let singleSynthesizer = SingletonSynthesizer.shared
    
    override func viewWillDisappear(_ animated: Bool) {
        if singleSynthesizer.isSpeaking == true {
            singleSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        }
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(true)
//        if synthesizer.isSpeaking == true {
//            synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
//        }
//        print("OK")
//    }
    
    deinit {
        print("De init !!!!!!!!!!!!!!!")
    }
}

// MARK:- CV Data Source Methods
extension VocabularyWordListVC: UICollectionViewDataSource {
    
    
    // Handle Collection View Cell
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        self.cellHeight[indexPath] = cell.frame.size.height
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.wordList.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath.row)
        let rowData = self.wordList[indexPath.row]
        print("\(rowData)")
        
        if self.indexPath == 8 || self.indexPath == 9 || self.indexPath == 11 {
            print("This is 17")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: VocabularyWordListCellForPhoto.self), for: indexPath) as! VocabularyWordListCellForPhoto
            
            cell.wordTitleLabel.text = rowData.wordTitle
            cell.wordPhoneticsLabel.text = "[" + "\(rowData.wordPhonetics)" + "]"
            //                cell.wordPhoneticsLabel.text = "[" + "\(indexPath.row)" + "]"
            cell.wordMeaningLabel.text = rowData.wordMeaning
            cell.wordNumberLabel.text = rowData.wordNumber
            cell.wordGenderLabel.text = rowData.wordGender
            //
            //        print("WORDLLIST :", rowData.wordCd)
            //        print("WordConfused :", rowData.wordConfused)
            //
            //
            if rowData.wordConfused == "oui" {
                switch cell.wordGenderLabel.text {
                case "f.":
                    cell.wordGenderLabel.textColor = .red
                default:
                    cell.wordGenderLabel.textColor = .blue
                }
            }
            cell.wordPartOfSpeechLabel.text = rowData.wordPartOfSpeech
            let imageName: String = rowData.wordFrenchExam
            cell.showImageView.image = UIImage(named: imageName)
            cell.willSayWord = rowData.wordTitle
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: VocabularyWordListCellForSentence.self), for: indexPath) as! VocabularyWordListCellForSentence
            
            cell.wordTitleLabel.text = rowData.wordTitle
            cell.wordPhoneticsLabel.text = "[" + "\(rowData.wordPhonetics)" + "]"
            //                cell.wordPhoneticsLabel.text = "[" + "\(indexPath.row)" + "]"
            cell.wordMeaningLabel.text = rowData.wordMeaning
            cell.wordNumberLabel.text = rowData.wordNumber
            cell.wordGenderLabel.text = rowData.wordGender
            //
            //        print("WORDLLIST :", rowData.wordCd)
            //        print("WordConfused :", rowData.wordConfused)
            //
            //
            if rowData.wordConfused == "oui" {
                switch cell.wordGenderLabel.text {
                case "f.":
                    cell.wordGenderLabel.textColor = .red
                default:
                    cell.wordGenderLabel.textColor = .blue
                }
            }
            cell.wordPartOfSpeechLabel.text = rowData.wordPartOfSpeech
            cell.wordFrenchExamLabel.text = rowData.wordFrenchExam
            cell.wordKoreanExamLabel.text = rowData.wordKoreanExam
            
            cell.willSayWord = rowData.wordTitle
            cell.willSaySentence = rowData.wordFrenchExam
            return cell
        }
       
//        return cell
        
    }
    
    
    
    
    // Handle Collection View Header
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // Section 의 텍스트는 4번 불리기 때문에 어레이 타입의 배열을 넣어야지 굳이 스위치문으로 나눌 필요가 없다.
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: VocabularyWordListHeader.self), for: indexPath) as! VocabularyWordListHeader
        
        // 아래의 텍스트로는 각 섹션의 타이틀이 들어갈 예정입니다.
        header.koreanTitleLabel.text = self.subjectInfo.subjectKoreanTitle
        header.subFrenchTitleLabel.text = self.subjectInfo.subjectFrenchTitle
        header.subSentenceLabel.text = "\(self.subjectInfo.subjectSentence)"
        header.menuImageView.image = UIImage(named: "\(self.subjectInfo.subjectFrenchTitle)")
        return header
    }
    
    
}

// MARK:- CV Delegate Flow Layout Methods
extension VocabularyWordListVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 각 셀의 크기는 균일할 것이기 때문에 굳이 스위치문으로 나눌 필요가 없다. 후에 각 셀의 크기를 다르게 지정해 줄 때에는 나눔.
        //        return UICollectionViewFlowLayout.automaticSize
        if self.indexPath == 8 || self.indexPath == 9 || self.indexPath == 11 {
            return VocabularyWordListCellForPhoto.defineCellSize(cellwidth: self.view.frame.width)
        }
        return VocabularyWordListCellForSentence.defineCellSize(cellwidth: self.view.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // Section 의 사이즈는 균일하기 때문에 굳이 스위치문으로 나눌 필요가 없다.
        return VocabularyWordListHeader.defineCellSize(cellwidth: self.view.frame.width)
    }
    
}
