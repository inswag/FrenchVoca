//
//  SettingPeopleCVC.swift
//  FrenchVoca
//
//  Created by 박인수 on 20/04/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit
import Foundation

class SettingPeopleCVC: UICollectionViewController {
    
    let frenchVocaLogoView: UIView = {
        let view = UIView(frame: CGRect(x:  0, y: 0, width: 110, height: 27)) // 110/27
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionViewSetting()
        self.setupUIDesign()
    }
    
    fileprivate func collectionViewSetting() {
        
        self.collectionView.register(SettingMainCell.self, forCellWithReuseIdentifier: String(describing: SettingMainCell.self))
        self.collectionView.backgroundColor = .red
//        self.collectionView.collectionViewLayout = self.flowLayout
    }
    
    
    func setupUIDesign() {
        // Navigation Bar
        self.navigationItem.titleView = frenchVocaLogoView
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
}

//MARK:- Collection View Data Source Methods
extension SettingPeopleCVC {
    
    // Handle Collection View Number Of Items In Section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    // Handle Collection View Cell For Item AT
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        switch indexPath.row {
//        case 0:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WelcomeMainWordCell.self), for: indexPath) as! WelcomeMainWordCell
//            return cell
//        case 1:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WelcomeMainNoticeCell.self), for: indexPath) as! WelcomeMainNoticeCell
//            return cell
//        default:
//            print("NOTHING")
//        }
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WelcomeMainWordCell.self), for: indexPath) as! WelcomeMainWordCell
//        return cell
//    }
    
    // Handle Collection View Header
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: WelcomeMainProfileHeader.self), for: indexPath) as! WelcomeMainProfileHeader
//
//        let plist = UserDefaults.standard
//        header.usernameLabel.text = plist.string(forKey: "이름")
//        header.positionLabel.text = plist.string(forKey: "소속")
//        if let imageData = plist.data(forKey: "이미지") {
//            header.profileImageView.image = UIImage(data: imageData)
//        }
//        header.backgroundColor = .white
//        return header
//    }
}


//MARK:- Collection View Delegate Flow Layout Methods
extension SettingPeopleCVC: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        switch indexPath.row {
//        case 0:
//            return WelcomeMainWordCell.defineCellSize(cellwidth: self.view.frame.width)
//        case 1:
//            return WelcomeMainNoticeCell.defineCellSize(cellwidth: self.view.frame.width)
//        default:
//            return WelcomeMainWordCell.defineCellSize(cellwidth: self.view.frame.width)
//        }
//
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return WelcomeMainProfileHeader.defineCellSize(cellwidth: self.view.frame.width)
//    }
    
}


