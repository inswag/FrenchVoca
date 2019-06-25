//
//  WelcomeViewController.swift
//  FrenchVoca
//
//  Created by 박인수 on 24/01/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    // MARK:- Custom Navigation Bar
    let frenchVocaLogoView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 110, height: 27)) // 110/27
        let label = UILabel()
        view.addSubview(label)
        label.text = "French Voca"
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Book", size: 20)
        label.textColor = UIColor.rgb(red: 74, green: 74, blue: 74)
        label.numberOfLines = 1
        label.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        return view
    }()

    lazy var barBtnDELF = UIBarButtonItem(title: "DELF", style: .plain, target: self, action: #selector(delfBtnAction))
    @objc func delfBtnAction() {
        self.navigationController?.pushViewController(DELFScheduleViewController(), animated: true)
    }
    
    lazy var barBtnFLEX = UIBarButtonItem(title: "FLEX", style: .plain, target: self, action: #selector(flexBtnAction))
    @objc func flexBtnAction() {
        self.navigationController?.pushViewController(FLEXScheduleViewController(), animated: true)
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
        cv.register(WelcomeMainNoticeCell.self, forCellWithReuseIdentifier: String(describing: WelcomeMainNoticeCell.self))
        cv.register(WelcomeMainWordCell.self, forCellWithReuseIdentifier: String(describing: WelcomeMainWordCell.self))
        // Anchor 는 클로저 바깥에서 잡아주어야 한다.
        return cv
    }()
    
    let notiManager = UNNotiManager()
    
    //MARK:- View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIDesign()
        setupCustomNaviBarDesign()
        
        notiManager.getNotificationSettings { isAuthorized in
            guard  isAuthorized else { return }
        }
        notiManager.triggerTimeIntervalNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.collectionView.reloadData() // Userdefault 적용 하지만 뷰가 나타낼때마다 리로드해주는건 너무 좋지 않다. 다른 방법을 찾으시오.
    }
    
    
    //MARK:- Design
    fileprivate func setupUIDesign() {
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    fileprivate func setupCustomNaviBarDesign() {
        barBtnDELF.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Avenir-Black", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 74, green: 74, blue: 74)], for: .normal)
        barBtnFLEX.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Avenir-Black", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 74, green: 74, blue: 74)], for: .normal)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: frenchVocaLogoView)
        self.navigationItem.rightBarButtonItems = [barBtnDELF, barBtnFLEX]
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    //MARK:- Deinit
    deinit {
        print("Welcome VC deinit")
    }
    
}


//MARK:- Collection View Data Source Methods
extension WelcomeViewController: UICollectionViewDataSource {
    
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
        
        let plist = UserDefaults.standard
        header.usernameLabel.text = plist.string(forKey: "이름")
        header.positionLabel.text = plist.string(forKey: "소속")
        if let imageData = plist.data(forKey: "이미지") {
            header.profileImageView.image = UIImage(data: imageData)
        }
        header.backgroundColor = .white
        return header
    }
}


//MARK:- Collection View Delegate Flow Layout Methods
extension WelcomeViewController: UICollectionViewDelegateFlowLayout {
    
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
        return WelcomeMainProfileHeader.defineCellSize(cellwidth: self.view.frame.width)
    }
    
}
