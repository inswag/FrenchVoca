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
    let plist = UserDefaults.standard
    
    let titleLabel = ["등록 정보 변경", "개발자와 친구들", "알림 On/Off","알림 설정"]
    let subtitleLabel = ["Changer votre inscription", "Développeur et ses amis", "Allumer/éteindre vos notis","Paramètre de Notifications"]
    
    // MARK:- UI Properties
    
    let settingNaviTitle: UILabel = {
        let label = UILabel()
        label.text = "Paramètre"
        label.textAlignment = .center
        label.font = Tools.font.avenirBook(size: 20)
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        return label
    }()
    
    lazy var tableview: UITableView = {
        let tv = UITableView(frame: UIScreen.main.bounds,
                             style: UITableView.Style.plain)
        tv.backgroundColor = .white
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(SettingDefaultCell.self, forCellReuseIdentifier: String(describing: SettingDefaultCell.self))
        tv.register(SettingSwitchCell.self, forCellReuseIdentifier: String(describing: SettingSwitchCell.self))
        return tv
    }()
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let identifierTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Carte d'étudiant"
        label.textAlignment = .left
        label.font = Tools.font.avenirLight(size: 14)
        label.textColor = Tools.color.mediumBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 45 // imageView Size 60 * 60
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "VOTRE SURNOM"
        label.textAlignment = .left
        label.font = Tools.font.avenirBlack(size: 20)
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let positionLabel: UILabel = {
        let label = UILabel()
        label.text = "Votre position"
        label.textAlignment = .left
        label.font = Tools.font.avenirBook(size: 15)
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
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
//        imagePickerResponse()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK:- Methods
    

    
    // MARK:- UI Methods
    
    override func setupUIComponents() {
        self.navigationItem.titleView = settingNaviTitle
        
        usernameLabel.text = plist.string(forKey: "이름")
        positionLabel.text = plist.string(forKey: "소속")
        if let imageData = plist.data(forKey: "이미지") {
            profileImageView.image = UIImage(data: imageData)
        }
        
        let nameStackView = UIStackView(arrangedSubviews: [usernameLabel, positionLabel])
        nameStackView.axis = .vertical
        nameStackView.spacing = 8
        nameStackView.distribution = .fillEqually
        
        [identifierTitleLabel, profileImageView, nameStackView].forEach {
            headerView.addSubview($0)
        }
        
        identifierTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)            // FontSize + 10
            $0.leading.equalToSuperview().offset(16)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(identifierTitleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
            $0.width.height.equalTo(90)
        }
        
        nameStackView.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.width.equalToSuperview().offset(-16)
            $0.height.equalTo(Tools.font.avenirBlack(size: 20).lineHeight + Tools.font.avenirBook(size: 15).lineHeight + 8)
            $0.centerY.equalTo(profileImageView.snp.centerY)
        }
//
        
        
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
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingSwitchCell.self), for: indexPath) as! SettingSwitchCell
            cell.selectionStyle = .none
            cell.titleLabel.text = self.titleLabel[indexPath.row]
            cell.subTitleLabel.text = self.subtitleLabel[indexPath.row]
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingDefaultCell.self), for: indexPath) as! SettingDefaultCell
        cell.selectionStyle = .none
        cell.titleLabel.text = self.titleLabel[indexPath.row]
        cell.subTitleLabel.text = self.subtitleLabel[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
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
        return SettingDefaultCell.defineCellHeight()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 138 + Tools.font.avenirLight(size: 14).lineHeight
    }
    
    
}
