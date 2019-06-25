//
//  Setting.swift
//  FrenchVoca
//
//  Created by 박인수 on 03/04/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit
import Foundation

class SettingTableViewController: UITableViewController {
    
    let cellID = "cellID"
    let titleLabel = ["등록 정보 변경", "오픈소스 라이센스", "개발자", "Thanks to"]
    let subtitleLabel = ["Changer votre inscription", "Open source license", "Développeur", "Merci à"]
//    let img = ["C", "O", "D", "M"]
    
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
        
        self.tableView.backgroundColor = .white
        self.tableView.register(SettingMainCell.self, forCellReuseIdentifier: cellID)
        self.tableView.estimatedRowHeight = 30
        setupUIDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func setupUIDesign() {
        // Navigation Bar
        self.navigationItem.titleView = frenchVocaLogoView
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
    }
    
}

extension SettingTableViewController {
    
    override func tableView(_ tablView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        self.selectedID = self.movieInfos[indexPath.row].id
//        let movieDetailViewController = MovieDetailViewController()
//        movieDetailViewController.receivedValue = self.selectedID
//        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
        
        switch indexPath.row {
        case 0:
            let settingModifyInfoViewController = SettingModifyInfoViewController()
            settingModifyInfoViewController.modalPresentationStyle = .overCurrentContext
//            self.navigationController?.pushViewController(settingModifyInfoViewController, animated: true)
            self.present(settingModifyInfoViewController, animated: true, completion: nil)
            print("indexPath.row == 0")
            // 학생증 형식으로 만들어서 기존의 학생증 틀과 새로운 학생증 틀을 동시에 보여준 후 기존에는 유저디폴트를 활용하여 보여주고 새로운 학생증 틀에는 이미지 피커 컨트롤러를 넣어서 새롭게 유저디폴트에 저장시켜버리기~~!
        case 1:
            print("indexPath.row == 1")
        case 2:
            print("indexPath.row == 2")
        default:
            print("indexPath.row == 3")
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleLabel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SettingMainCell
//        cell.imageIcon.image = UIImage(named: "\(self.img[indexPath.row])")
        cell.titleLabel.text = self.titleLabel[indexPath.row]
        cell.subTitleLabel.text = self.subtitleLabel[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SettingMainCell.defineCellHeight()
    }
    
    
}



