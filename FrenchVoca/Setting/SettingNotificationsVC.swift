//
//  SettingNotificationsVC.swift
//  FrenchVoca
//
//  Created by 박인수 on 18/11/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit
import SnapKit

class SettingNotificationsVC: UIViewController {
    
    // MARK:- Properties
    
    let application = Application.shared
    
    // MARK:- UI Properties

    // Back Button
    let backButtonIcon: UIButton = {
        let button = UIButton()
        let popBtn = UIImage(named: "Pop_Black_Button")
        button.setImage(popBtn, for: .normal)
        button.addTarget(self, action: #selector(handlePopAction), for: .touchUpInside)
        return button
    }()
    
    let backButtonText: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSAttributedString(string: "Arrière", attributes: [NSAttributedString.Key.font: Tools.font.avenirLight(size: 20), NSAttributedString.Key.foregroundColor: Tools.color.lightBlack])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handlePopAction), for: .touchUpInside)
        return button
    }()
    
    @objc func handlePopAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Title Label
    let titleLabel: UILabel = {
        // France Blue RGB : 36 74 156
        let titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.white
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        titleLabel.text = "단어 알림 시간을 알려주세요"
        titleLabel.font = Tools.font.avenirBlack(size: 23)
        titleLabel.adjustsFontSizeToFitWidth = true
        return titleLabel
    }()
    
    let subtitleLabel: UILabel = {
        // France Blue RGB : 36 74 156
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "(Notifications de mots)"
        label.font = Tools.font.avenirLight(size: 20)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let commentLabel: UILabel = {
        // France Blue RGB : 36 74 156
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "   * 넘어가기(Sautez)시 기본 알림은 3시간입니다."
        label.font = Tools.font.avenirLight(size: 11)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let minuteTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "여기를 터치해 분(minute) 단위로 적어주세요"
        textField.backgroundColor = UIColor.white
        textField.textAlignment = .left
        textField.borderStyle = .none
        textField.font = Tools.font.avenirLight(size: 17)
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
    }()
    
    @objc func handleTextInputChange() {
        let isFormVaild = minuteTextField.text?.isEmpty != true

        if isFormVaild {
            saveButton.isEnabled = true
            saveButton.backgroundColor = Tools.color.frenchBlue
        } else {
            saveButton.isEnabled = false
            saveButton.backgroundColor = Tools.color.darkGray
        }
    }
    
    // Button Stack View
    let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("넘어가기\n(Sautez)", for: .normal)
        button.backgroundColor = Tools.color.frenchBlue // 활성화 색상
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel!.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()
    
    @objc func handleSkip() {
        // register 'Time' in UserDefault
        let plist = UserDefaults.standard
        plist.set(10800, forKey: "알림시간")
        plist.synchronize()
        
        // Keyboard Dismiss
        self.view.endEditing(true)
        
        // Authentification of Noti
        application.notiManager.getNotificationSettings { isAuthorized in
            guard  isAuthorized else { return }
        }
        application.notiManager.triggerTimeIntervalNotification(time: plist.double(forKey: "알림시간"))
        
        print("Noti Skip setting OK")
        
        // 메인 뷰 진입
        self.navigationController?.popViewController(animated: true)
    }
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("저장\n(Sauvegardez)", for: .normal)
        button.backgroundColor = Tools.color.darkGray // 비활성화 색상
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel!.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()
    
    @objc func handleSave() {
        print("OK handleSave")
    
        // register 'Time' in UserDefault // QQQQQ 60을 어떻게 추가할까
        let plist = UserDefaults.standard
        
        if let doubleValue = Double(self.minuteTextField.text ?? "") {
            plist.set(doubleValue * 60.0, forKey: "알림시간")
            plist.synchronize()
        }
        
        // Keyboard Dismiss
        self.view.endEditing(true)
        
        // Authentification of Noti
        application.notiManager.getNotificationSettings { isAuthorized in
            guard  isAuthorized else { return }
        }
        application.notiManager.triggerTimeIntervalNotification(time: plist.double(forKey: "알림시간"))
        
        print("Noti User Setting OK")
        
        // 메인 뷰 진입
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        setupUIComponents()
    }
    
    // MARK:- UI Methods
    
    func setupUIComponents() {
        
        [minuteTextField, backButtonIcon, backButtonText].forEach { self.view.addSubview($0) }
        
        self.backButtonIcon.snp.makeConstraints { (m) in
            m.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(20)
            m.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(20)
        }
        
        self.backButtonText.snp.makeConstraints { (m) in
            m.leading.equalTo(backButtonIcon.snp.trailing).offset(5)
            m.centerY.equalTo(backButtonIcon)
        }
        
        // UIStackView - label
        let labelStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        labelStackView.axis = .vertical
        labelStackView.spacing = 3
        labelStackView.distribution = .fillEqually

        [labelStackView, commentLabel].forEach { self.view.addSubview($0) }
        
        let textHeight = titleLabel.font.lineHeight + subtitleLabel.font.lineHeight + 3

        labelStackView.snp.makeConstraints { (m) in
            m.top.equalTo(backButtonIcon.snp.bottom).offset(40)
            m.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(20)
            m.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).offset(-20)
            m.height.equalTo(textHeight)
        }
        
        commentLabel.snp.makeConstraints { (m) in
            m.top.equalTo(labelStackView.snp.bottom).offset(1)
            m.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(20)
            m.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).offset(-20)
        }

        minuteTextField.snp.makeConstraints { (m) in
            m.top.equalTo(commentLabel.snp.bottom).offset(10)
            m.leading.equalTo(backButtonIcon.snp.leading)
            m.trailing.equalTo(self.view.snp.trailingMargin).offset(-20)
            m.height.equalTo(50)
        }
        
        // UIStackView - Button
        let btnStackView = UIStackView(arrangedSubviews: [skipButton, saveButton])
        btnStackView.axis = .horizontal
        btnStackView.spacing = 20
        btnStackView.distribution = .fillEqually
        
        [btnStackView].forEach { self.view.addSubview($0) }
        
        btnStackView.snp.makeConstraints { (m) in
            m.top.equalTo(minuteTextField.snp.bottom).offset(10)
            m.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(20)
            m.width.equalTo(260) // 120 + 120 + 20
            m.height.equalTo(40)
        }
    
    }
    
    // MARK:- Touch Event
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
