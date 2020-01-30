//
//  SignInController.swift
//  FrenchVocaProject
//
//  Created by 박인수 on 22/12/2018.
//  Copyright © 2018 inswag. All rights reserved.
//

import UIKit
import Foundation

class SignInViewController: UIViewController {
    
    // MARK:- Properties
    
    var img = UIImage(named: "login_Photos")
    
    
    // MARK:- UI Properties
    
    // Title Label
    let titleLabel: UILabel = {
        // France Blue RGB : 36 74 156
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.text = "맞나요?\nPas d'erreur ?"
        titleLabel.textColor = Tools.color.lightBlack
        titleLabel.font = Tools.font.avenirLight(size: 23)
        titleLabel.adjustsFontSizeToFitWidth = true
        return titleLabel
    }()
    
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
        navigationController?.popViewController(animated: true)
    }
    
    // Photo & Username & Position & Login in Container View
    let containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = Tools.color.mediumBlack.cgColor
        view.layer.cornerRadius = 15
        return view
    }()
    
    let studentCardLabel: UILabel = {
        let label = UILabel()
        let underlineAttriString = NSAttributedString(string: "Carte d'étudiant",
                                                      attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                                                                   NSAttributedString.Key.font: Tools.font.avenirLight(size: 14),
                                                                   NSAttributedString.Key.foregroundColor: Tools.color.lightBlack])
        label.attributedText = underlineAttriString
        return label
    }()
    
    let chosenUserPhoto: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "login_Photos")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 100 / 2
        iv.clipsToBounds = true
        return iv
    }()
    
    // Label Stack View
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "VOTRE SURNOM"
        label.textAlignment = .center
        label.font = Tools.font.avenirBlack(size: 25)
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let positionLabel: UILabel = {
        let label = UILabel()
        label.text = "Votre position"
        label.textAlignment = .center
        label.font = Tools.font.avenirBook(size: 20)
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // Button Stack View
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("저장\n(Sauvegardez)", for: .normal)
        button.backgroundColor = Tools.color.frenchBlue // 활성화 색상
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
        // 인스턴스 생성 말고 다른방법은 없을까? 이 방법 안되는데... 델리게이트나 노티피케이션을 좀 알아보자
//        let welcomeVC = ReceptionViewController()
//        welcomeVC.collectionView.reloadData()
//
        // Handling UX Design
        self.loginButton.isEnabled = true
        self.loginButton.backgroundColor = Tools.color.frenchBlue
        self.saveButton.isEnabled = false
        self.saveButton.backgroundColor = Tools.color.darkGray
    }
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("다음\n(Suivant)", for: .normal)
        button.backgroundColor = Tools.color.darkGray // 비활성화 색상
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel!.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()
    
    @objc func handleNext() {
        print("OK handleNext")
        
        if self.usernameLabel.text?.isEmpty != true && self.positionLabel.text?.isEmpty != true {
            let plist = UserDefaults.standard
            plist.set(self.usernameLabel.text, forKey: "이름")
            plist.set(self.positionLabel.text, forKey: "소속")
            if let imageData = self.chosenUserPhoto.image?.jpegData(compressionQuality: 0.3) {
                plist.set(imageData, forKey: "이미지")
                print("imageData OK")
            }
            plist.synchronize()
        }
        
        let notiSettingVC = NotiSettingViewController()
        navigationController?.pushViewController(notiSettingVC, animated: true)
    }
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUIComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // UX Design
        if self.chosenUserPhoto.image == nil { chosenUserPhoto.image = self.img }
        self.loginButton.isEnabled = false
        self.saveButton.isEnabled = true
    }
    
    // MARK:- UI Design
    
    func setupUIComponents() {
        let labelStackView = UIStackView(arrangedSubviews: [usernameLabel, positionLabel])
        labelStackView.axis = .vertical
        labelStackView.spacing = 20
        labelStackView.distribution = .fillEqually
        
        let btnStackView = UIStackView(arrangedSubviews: [saveButton, loginButton])
        btnStackView.axis = .horizontal
        btnStackView.spacing = 20
        btnStackView.distribution = .fillEqually
        
        [titleLabel, backButtonIcon, backButtonText, containerView, btnStackView].forEach { self.view.addSubview($0) }
        [studentCardLabel, chosenUserPhoto, labelStackView].forEach { self.containerView.addSubview($0) }
        
        self.titleLabel.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 0)
        self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        
        self.backButtonIcon.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        self.backButtonText.anchor(top: nil, left: self.backButtonIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        self.backButtonText.centerYAnchor.constraint(equalTo: self.backButtonIcon.centerYAnchor).isActive = true
        
        let containerHeight: CGFloat = self.studentCardLabel.font.lineHeight + 310
        self.containerView.anchor(top: self.titleLabel.bottomAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 40, paddingLeft: 80, paddingBottom: 0, paddingRight: 80, width: 0, height: containerHeight)
        
        
        
        self.studentCardLabel.anchor(top: self.containerView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        self.studentCardLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        chosenUserPhoto.anchor(top: self.studentCardLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 100) // Height 100
        chosenUserPhoto.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        // (each label size 40 * 3) + (spacing 20 * 2)
        labelStackView.anchor(top: self.chosenUserPhoto.bottomAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: self.view.safeAreaLayoutGuide.rightAnchor, paddingTop: 40, paddingLeft: 60, paddingBottom: 0, paddingRight: 60, width: 0, height: 100) // Height 140
        
        // (each button size 40 * 2) + (spacing 20 * 1)
        btnStackView.anchor(top: self.containerView.bottomAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: self.view.safeAreaLayoutGuide.rightAnchor, paddingTop: 20, paddingLeft: 60, paddingBottom: 0, paddingRight: 60, width: self.view.frame.width - 120, height: 40) // Height 60 + 10(btm) = 70
    }
    
}
