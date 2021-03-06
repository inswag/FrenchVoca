//
//  ReceptionViewController.swift
//  FrenchVoca
//
//  Created by 박인수 on 24/01/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

protocol ReceptionHeaderDelegate: class {
    func leftImageTapped()
    func rightImageTapped()
}

class ReceptionViewController: UIViewController {
    
    // MARK:- UI Properties
    
    let frenchVocaLogo: UILabel = {
        let label = UILabel()
        label.text = "French Voca"
        label.textAlignment = .center
        label.font = Tools.font.avenirBook(size: 20)
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        return label
    }()

    lazy var barBtnDELF = UIBarButtonItem(title: "DELF", style: .plain, target: self, action: #selector(delfBtnAction))
    @objc func delfBtnAction() {
        self.navigationController?.pushViewController(DELFViewController(), animated: true)
    }
    
    lazy var barBtnFLEX = UIBarButtonItem(title: "FLEX", style: .plain, target: self, action: #selector(flexBtnAction))
    @objc func flexBtnAction() {
        self.navigationController?.pushViewController(FLEXViewController(), animated: true)
    }
    
    //MARK:- WelcomeVC Collection View
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.setCollectionViewLayout(layout, animated: true)
        cv.dataSource = self
        cv.delegate = self
        cv.register(WelcomeMainProfileHeader.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: String(describing: WelcomeMainProfileHeader.self))
        cv.register(WelcomeMainNoticeCell.self,
                    forCellWithReuseIdentifier: String(describing: WelcomeMainNoticeCell.self))
        cv.register(WelcomeMainWordCell.self,
                    forCellWithReuseIdentifier: String(describing: WelcomeMainWordCell.self))
        // Anchor 는 클로저 바깥에서 잡아주어야 한다.
        return cv
    }()
        
    //MARK:- View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIComponents()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
        self.collectionView.reloadData() // Userdefault 적용 하지만 뷰가 나타낼때마다 리로드해주는건 너무 좋지 않다. 다른 방법을 찾으시오.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    
    //MARK:- Design
    
    fileprivate func setupUIComponents() {
        self.navigationItem.titleView = frenchVocaLogo
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    private func switchStateAlert() {
           let alert = UIAlertController(title: nil,
                                         message: "알람 허용 안함을 선택하셨습니다.\n알림을 받기 위해서는 아이폰 설정 - FrenchVoca - 알림 ON - 앱에서 Paramètre 선택 -> 알림 ON 을 해주세요.",
                                         preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK",
                                         style: .default,
                                         handler: nil))
           self.present(alert, animated: true)
       }
    
    //MARK:- Deinit
    
    deinit {
        print("Welcome VC deinit")
    }
    
}


//MARK:- Collection View Data Source Methods
extension ReceptionViewController: UICollectionViewDataSource {
    
    // Handle Collection View Number Of Items In Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    // Handle Collection View Cell For Item AT
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WelcomeMainWordCell.self), for: indexPath) as! WelcomeMainWordCell
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WelcomeMainNoticeCell.self), for: indexPath) as! WelcomeMainNoticeCell
            return cell
        default:
            print("NOTHING")
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WelcomeMainWordCell.self), for: indexPath) as! WelcomeMainWordCell
        return cell
    }
    
    // Handle Collection View Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: WelcomeMainProfileHeader.self), for: indexPath) as! WelcomeMainProfileHeader
        header.delegate = self
        return header
    }
}




//MARK:- Collection View Delegate Flow Layout Methods
extension ReceptionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.row {
        case 0:
            return WelcomeMainWordCell.defineCellSize(cellwidth: self.view.frame.width)
        case 1:
            return WelcomeMainNoticeCell.defineCellSize(cellwidth: self.view.frame.width)
        default:
            return WelcomeMainWordCell.defineCellSize(cellwidth: self.view.frame.width)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
//        return CGSize(width: self.view.frame.width, height: 250)
        return WelcomeMainProfileHeader.defineCellSize(cellwidth: self.view.frame.width)
    }
    
}

extension ReceptionViewController: ReceptionHeaderDelegate {
    
    func leftImageTapped() {
        self.navigationController?.pushViewController(FLEXViewController(), animated: true)
    }
    
    func rightImageTapped() {
        self.navigationController?.pushViewController(DELFViewController(), animated: true)
    }
}
