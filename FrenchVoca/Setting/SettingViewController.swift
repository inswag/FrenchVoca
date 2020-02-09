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
    
    let navigate: Navigator
    
    let titleLabel = ["등록 정보 변경", "개발자와 친구들", "알림 On/Off","알림 설정"]
    let subtitleLabel = ["Changer votre inscription", "Développeur et ses amis", "Allumer/éteindre vos notis","Paramètre de Notifications"]
    
    // MARK:- UI Properties
    
    lazy var tableview: UITableView = {
        let tv = UITableView(frame: UIScreen.main.bounds, style: UITableView.Style.grouped)
        tv.backgroundColor = .white
        tv.estimatedRowHeight = 150
//        tv.rowHeight = UITableView.automaticDimension
//        tv.contentInset =
        tv.separatorStyle = .none
//        tv.allowsSelection = false
        tv.showsVerticalScrollIndicator = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(SettingMainCell.self, forCellReuseIdentifier: String(describing: SettingMainCell.self))
        tv.register(SettingMainSwitchCell.self, forCellReuseIdentifier: String(describing: SettingMainSwitchCell.self))
        return tv
    }()
    
    // MARK;- Initialize
    
    init(navigator: Navigator) {
        navigate = navigator
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            m.top.bottom.leading.trailing.equalToSuperview()
        }
    }

}

// MARK: - Table View Data Source

extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.titleLabel.count
    }
    
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.item == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingMainSwitchCell.self), for: indexPath) as! SettingMainSwitchCell
            cell.selectionStyle = .none
            cell.titleLabel.text = self.titleLabel[indexPath.row]
            cell.subTitleLabel.text = self.subtitleLabel[indexPath.row]
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingMainCell.self), for: indexPath) as! SettingMainCell
        cell.selectionStyle = .none
        cell.titleLabel.text = self.titleLabel[indexPath.row]
        cell.subTitleLabel.text = self.subtitleLabel[indexPath.row]
        return cell
        
    }
    
}

// MARK: - Table View Delegate

extension SettingViewController: UITableViewDelegate {
    
    func tableView(_ tablView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            self.present(navigate.get(segue: .settingModifyInfo), animated: true, completion: nil)
        // 학생증 형식으로 만들어서 기존의 학생증 틀과 새로운 학생증 틀을 동시에 보여준 후 기존에는 유저디폴트를 활용하여 보여주고 새로운 학생증 틀에는 이미지 피커 컨트롤러를 넣어서 새롭게 유저디폴트에 저장시켜버리기~~!
        case 1:
            self.navigationController?.pushViewController(navigate.get(segue: .settingPeople), animated: true)
        case 3:
            self.navigationController?.pushViewController(navigate.get(segue: .settingNoti), animated: true)
        default:
            print("Error")
        }
        
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SettingMainCell.defineCellHeight()
    }
}
