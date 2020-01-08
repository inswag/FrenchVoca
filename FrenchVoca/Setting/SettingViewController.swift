//
//  SettingViewController.swift
//  FrenchVoca
//
//  Created by 박인수 on 08/01/2020.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

class SettingViewController: ViewController {
    
    // MARK:- Properties
    
    let cellID = "cellID"
    let cellID2 = "cellswitchID"
    let titleLabel = ["등록 정보 변경", "개발자와 친구들", "알림 On/Off","알림 설정"]
    let subtitleLabel = ["Changer votre inscription", "Développeur et ses amis", "Allumer/éteindre vos notis","Paramètre de Notifications"]
    
    // MARK:- UI Properties
    
    lazy var tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.estimatedRowHeight = 150
        tv.rowHeight = UITableView.automaticDimension
//        tv.contentInset =
        tv.separatorStyle = .none
//        tv.allowsSelection = false
        tv.showsVerticalScrollIndicator = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(SettingMainCell.self, forCellReuseIdentifier: cellID)
        tv.register(SettingMainSwitchCell.self, forCellReuseIdentifier: cellID2)
        return tv
    }()
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK:- UI Methods
    
    override func setupUIComponents() {
        [tableview].forEach {
            self.view.addSubview($0)
        }
        
        tableview.snp.makeConstraints { (m) in
            m.top.equalToSuperview()
            m.leading.equalToSuperview()
            m.trailing.equalToSuperview()
            m.bottom.equalToSuperview()
        }
    }

}

// MARK: - Data Source

extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleLabel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.item == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID2, for: indexPath) as! SettingMainSwitchCell
            cell.selectionStyle = .none
            cell.titleLabel.text = self.titleLabel[indexPath.row]
            cell.subTitleLabel.text = self.subtitleLabel[indexPath.row]
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SettingMainCell
        cell.selectionStyle = .none
        cell.titleLabel.text = self.titleLabel[indexPath.row]
        cell.subTitleLabel.text = self.subtitleLabel[indexPath.row]
        return cell
        
    }
    
}

// MARK: - Delegate

extension SettingViewController: UITableViewDelegate {
    
    func tableView(_ tablView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SettingMainCell.defineCellHeight()
    }
}
