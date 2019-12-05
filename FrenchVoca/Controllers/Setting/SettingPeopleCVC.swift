//
//  SettingPeopleCollectionVC.swift
//  FrenchVoca
//
//  Created by 박인수 on 20/04/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit
import Foundation

class SettingPeopleCollectionVC: UICollectionViewController {
    
    // (Model) Setting -> People
    lazy var peopleGroups = PeopleGroup.allGroups()
    
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
        self.collectionView.register(SettingPeopleCell.self, forCellWithReuseIdentifier: String(describing: SettingPeopleCell.self))
        self.collectionView.register(SettingPeopleHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: SettingPeopleHeader.self))
        self.collectionView.backgroundColor = .white
    }
    
    func setupUIDesign() {
        // Navigation Bar
        self.navigationItem.titleView = frenchVocaLogoView
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
}

//MARK:- Collection View Data Source Methods
extension SettingPeopleCollectionVC {
    
    // Handle Collection View Number Of Items In Section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.peopleGroups[section].peoples.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // Development, Design, Database, Contents
        return self.peopleGroups.count
    }
    
    
    // Handle Collection View Cell For Item AT
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let selectedPeopleGroup = self.peopleGroups[indexPath.section]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SettingPeopleCell.self), for: indexPath) as! SettingPeopleCell
        cell.backgroundColor = .white
        cell.peopleNameLabel.text = selectedPeopleGroup.peoples[indexPath.row].name
        cell.peoplePositionLabel.text = selectedPeopleGroup.peoples[indexPath.row].insta
        let imageName: String = selectedPeopleGroup.peoples[indexPath.row].image
        cell.profileImage.image = UIImage(named: imageName)
        return cell
    }
    
    // Handle Collection View Header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: SettingPeopleHeader.self), for: indexPath) as! SettingPeopleHeader
        
        switch indexPath.section {
        case 0:
            header.peopleSectionTitle.text = "Développment"
        case 1:
            header.peopleSectionTitle.text = "Design"
        case 2:
            header.peopleSectionTitle.text = "Base de données"
        case 3:
            header.peopleSectionTitle.text = "Mots et exemples"
        default:
            header.peopleSectionTitle.text = "Merci"
        }
        
        return header
    }

}


//MARK:- Collection View Delegate Flow Layout Methods
extension SettingPeopleCollectionVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((self.view.frame.width - 15) / 4)
        return CGSize(width: width,
                      height: (width - 20) +
                        SettingPeopleCell.Constant.margin +
                        SettingPeopleCell.Constant.peopleNameFont!.lineHeight +
                        SettingPeopleCell.Constant.peoplePositionFont!.lineHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return SettingPeopleHeader.defineCellSize(cellwidth: self.view.frame.width)
    }
    
}


