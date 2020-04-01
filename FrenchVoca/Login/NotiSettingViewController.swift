//
//  NotificationSetting.swift
//  FrenchVoca
//
//  Created by 박인수 on 14/11/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit
import SnapKit


class NotiSettingViewController: ViewController {
    
    // MARK:- Properties
    
    let application = Application.shared
    let plist = UserDefaults.standard
    
    // MARK:- UI Properties
    
    let backButtonIcon: UIButton = {
        let button = UIButton()
        let popBtn = UIImage(named: "Pop_Black_Button")
        button.setImage(popBtn, for: .normal)
        button.addTarget(self, action: #selector(handlePopAction), for: .touchUpInside)
        return button
    }()
    
    let backButtonText: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSAttributedString(string: "Arrière",
                                                 attributes: [NSAttributedString.Key.font: Tools.font.avenirLight(size: 20),
                                                              NSAttributedString.Key.foregroundColor: Tools.color.lightBlack])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handlePopAction), for: .touchUpInside)
        return button
    }()
    
    @objc func handlePopAction() {
        navigationController?.popToRootViewController(animated: true)
    }
    
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
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "(Notifications de mots)"
        label.font = Tools.font.avenirBlack(size: 20)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let commentLabel: UILabel = {
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
    
    lazy var skipButton: UIButton = {
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
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("저장\n(Sauvegardez)", for: .normal)
        button.backgroundColor = Tools.color.frenchBlue // 비활성화 색상
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel!.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()
    
    @objc func handleSkip() {
        // register 'Time' in UserDefault
        plist.set(10800, forKey: "알림시간")
        plist.set(true, forKey: "알림설정확인")
        plist.synchronize()
        
        // Keyboard Dismiss
        self.view.endEditing(true)
        
        application.notiManager.getNotificationSettings { isAuthorized in
            guard  isAuthorized else { return }
        }
        
        application.notiManager.triggerTimeIntervalNotification(time: plist.double(forKey: "알림시간"))
        print("사용자가 선택한 시간 : ", plist.double(forKey: "알림시간"))
        
        self.switchStateAlert()
    }
    
    @objc func handleSave() {
        if plist.bool(forKey: "알람설정확인") == false {
            
        }
        
        print("OK handleSave")
        // register 'Time' in UserDefault // QQQQQ 60을 어떻게 추가할까
        
        if let doubleValue = Double(self.minuteTextField.text ?? "") {
            plist.set(doubleValue * 60.0, forKey: "알림시간")
            plist.synchronize()
        }
        
        // Keyboard Dismiss
        self.view.endEditing(true)
        
        application.notiManager.getNotificationSettings { isAuthorized in
            guard isAuthorized else { return }
        }
        
        application.notiManager.triggerTimeIntervalNotification(time: plist.double(forKey: "알림시간"))
        
        print("사용자가 선택한 시간 : ", plist.double(forKey: "알림시간"))
        
        plist.set(true, forKey: "알림설정확인")
        plist.synchronize()
        
        print("Noti User Setting OK")
        
        self.switchStateAlert()
    }
    
    private func switchStateAlert() {
        let alert = UIAlertController(title: nil,
                                      message: "알림 허용 하셨나요?\n안하셨다면 나중에\n아이폰 설정 - FrenchVoca - 알림 ON - 앱에서 Paramètre 선택 -> 알림 ON 을 해주세요.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "알겠습니다!",
                                      style: .default,
                                      handler: actionFinish(alert:)))
        self.present(alert, animated: true)
    }
    
    fileprivate func actionFinish(alert: UIAlertAction!) {
        // 메인 뷰 진입
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupNotification()
    }
    
    
    // MARK:- Methods
    
    func setupNotification() {
//        application.notiManager.register()  // Don't allow or allow (Just Once)
    }
    
    // MARK:- UI Methods
    
    override func setupUIComponents() {
        [minuteTextField, backButtonIcon, backButtonText].forEach {
            self.view.addSubview($0)
        }
        
        // UIStackView - label
        let labelStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        labelStackView.axis = .vertical
        labelStackView.spacing = 2
        labelStackView.distribution = .fillEqually

        [labelStackView, commentLabel].forEach {
            self.view.addSubview($0)
        }
        
        // UIStackView - Button
        let btnStackView = UIStackView(arrangedSubviews: [skipButton, saveButton])
        btnStackView.axis = .horizontal
        btnStackView.spacing = 20
        btnStackView.distribution = .fillEqually
        
        [btnStackView].forEach {
            self.view.addSubview($0)
        }
        
        let textHeight = titleLabel.font.lineHeight + subtitleLabel.font.lineHeight + 2
        
        labelStackView.snp.makeConstraints { (m) in
            m.top.equalTo(backButtonIcon.snp.bottom).offset(40)
            m.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(20)
            m.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).offset(-20)
            m.height.equalTo(textHeight)
        }
        
        commentLabel.snp.makeConstraints { (m) in
            m.top.equalTo(labelStackView.snp.bottom).offset(3)
            m.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(20)
            m.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).offset(-20)
        }
        
        btnStackView.snp.makeConstraints { (m) in
            m.top.equalTo(minuteTextField.snp.bottom).offset(10)
            m.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(20)
            m.width.equalTo(260) // 120 + 120 + 20
            m.height.equalTo(40)
        }
    }
    
    override func setupUILayout() {
        self.backButtonIcon.snp.makeConstraints { (m) in
            m.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(20)
            m.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(20)
        }
        
        self.backButtonText.snp.makeConstraints { (m) in
            m.leading.equalTo(backButtonIcon.snp.trailing).offset(5)
            m.centerY.equalTo(backButtonIcon)
        }
        
        self.minuteTextField.snp.makeConstraints { (m) in
            m.top.equalTo(commentLabel.snp.bottom).offset(10)
            m.leading.equalTo(backButtonIcon.snp.leading)
            m.trailing.equalTo(self.view.snp.trailingMargin).offset(-20)
            m.height.equalTo(50)
        }
    }
    
    // MARK:- Touch Event
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
