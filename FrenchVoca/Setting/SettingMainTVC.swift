//
//  Setting.swift
//  FrenchVoca
//
//  Created by 박인수 on 03/04/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class SettingMainTVC: UITableViewController {
    
    let cellID = "cellID"
    let cellID2 = "cellswitchID"
    let titleLabel = ["등록 정보 변경", "개발자와 친구들", "알림 On/Off","알림 설정"]
    let subtitleLabel = ["Changer votre inscription", "Développeur et ses amis", "Allumer/éteindre vos notis","Paramètre de Notifications"]
    
    let frenchVocaLogoView: UIView = {
        let view = UIView(frame: CGRect(x:  0, y: 0, width: 110, height: 27)) // 110/27
        let label = UILabel()
        view.addSubview(label)
        label.text = "French Voca"
        label.textAlignment = .left
        label.font = Tools.font.avenirBook(size: 20)
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        label.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = .white
        self.tableView.register(SettingMainCell.self, forCellReuseIdentifier: cellID)
        self.tableView.register(SettingMainSwitchCell.self, forCellReuseIdentifier: cellID2)
        
        setupUIComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func setupUIComponents() {
        // Navigation Bar
        self.navigationItem.titleView = frenchVocaLogoView
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
    }
    
}

extension SettingMainTVC {
    
    override func tableView(_ tablView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        self.selectedID = self.movieInfos[indexPath.row].id
        //        let movieDetailViewController = MovieDetailViewController()
        //        movieDetailViewController.receivedValue = self.selectedID
        //        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
        
        switch indexPath.row {
        case 0:
            let settingModifyInfoVC = SettingModifyInfoVC()
            settingModifyInfoVC.modalPresentationStyle = .overCurrentContext
            //            self.navigationController?.pushViewController(SettingModifyInfoVC, animated: true)
            self.present(settingModifyInfoVC, animated: true, completion: nil)
            print("indexPath.row == 0")
        // 학생증 형식으로 만들어서 기존의 학생증 틀과 새로운 학생증 틀을 동시에 보여준 후 기존에는 유저디폴트를 활용하여 보여주고 새로운 학생증 틀에는 이미지 피커 컨트롤러를 넣어서 새롭게 유저디폴트에 저장시켜버리기~~!
        case 1:
            print("indexPath.row == 1")
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
            flowLayout.minimumInteritemSpacing = 1.0
            flowLayout.minimumLineSpacing = 1.0
            let settingPeopleCollectionVC = SettingPeopleCollectionVC(collectionViewLayout: flowLayout)
            self.navigationController?.pushViewController(settingPeopleCollectionVC, animated: true)
        case 3:
            print("indexPath.row == 3")
            let settingNotiVC = SettingNotificationsVC()
//            settingNotiVC.modalPresentationStyle = .pageSheet
//            self.present(settingNotiVC, animated: true, completion: nil)
            self.navigationController?.pushViewController(settingNotiVC, animated: true)
            
        default:
            print("indexPath.row == ?")
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleLabel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.item == 2 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID2, for: indexPath) as! SettingMainSwitchCell
            cell.selectionStyle = .none
            cell.titleLabel.text = self.titleLabel[indexPath.row]
            cell.subTitleLabel.text = self.subtitleLabel[indexPath.row]
            return cell
        }
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SettingMainCell
        cell.selectionStyle = .none
        cell.titleLabel.text = self.titleLabel[indexPath.row]
        cell.subTitleLabel.text = self.subtitleLabel[indexPath.row]
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SettingMainCell.defineCellHeight()
    }
    
    
}





