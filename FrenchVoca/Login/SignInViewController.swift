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
    
    // MARK:- Constant
    
    struct UI {
        static let backIconTopMargin: CGFloat = 20
        static let backIconLeadingMargin: CGFloat = 20
        static let backTextLeadingMargin: CGFloat = 5
        static let bottomContainerHeight: CGFloat = 120
        static let titleTopMargin: CGFloat = 60
        static let titleWidth: CGFloat = 200
        static let containerTopMargin: CGFloat = 40
        static let containerLeadingMargin: CGFloat = 80
        static let containerTrailingMargin: CGFloat = -80
        static let containerHeight: CGFloat = 350
        static let studentCardTopMargin: CGFloat = 20
        static let chosenUserPhotoSize: CGFloat = 100
        static let chosenUserPhotoTopMargin: CGFloat = 30
        static let divisionViewWidth: CGFloat = 20
        static let divisionViewHeight: CGFloat = 8
        static let usernameBottomMargin: CGFloat = -8
        static let positionTopMargin: CGFloat = 8
        static let btnStackViewTopMargin: CGFloat = 32
        static let btnStackViewWidth: CGFloat = 275
        static let btnStackViewHeight: CGFloat = 40
    }
    
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
        view.layer.borderColor = Tools.color.cardBlue.cgColor
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
    
    
    let bottomContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Tools.color.cardBlue
        view.layer.borderWidth = 1
        view.layer.borderColor = Tools.color.mediumBlack.cgColor
        view.layer.cornerRadius = 15
        return view
    }()
    
    
    // Label Stack View
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "VOTRE SURNOM"
        label.textAlignment = .center
        label.font = Tools.font.avenirBlack(size: 25)
        label.textColor = .white
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let divisionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        return view
    }()
    
    let positionLabel: UILabel = {
        let label = UILabel()
        label.text = "Votre position"
        label.textAlignment = .center
        label.font = Tools.font.avenirBook(size: 20)
        label.textColor = .white
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
        
        let btnStackView = UIStackView(arrangedSubviews: [saveButton, loginButton])
        btnStackView.axis = .horizontal
        btnStackView.spacing = 20
        btnStackView.distribution = .fillEqually

        
        
        [titleLabel, backButtonIcon, backButtonText, containerView, btnStackView].forEach { self.view.addSubview($0) }
        
        
        [studentCardLabel, chosenUserPhoto, bottomContainerView].forEach { self.containerView.addSubview($0) }
        
        [usernameLabel, positionLabel, divisionView].forEach {
            self.bottomContainerView.addSubview($0)
        }
        
        backButtonIcon.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(UI.backIconTopMargin)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(UI.backIconLeadingMargin)
        }
        
        backButtonText.snp.makeConstraints {
            $0.leading.equalTo(self.backButtonIcon.snp.trailing).offset(UI.backTextLeadingMargin)
            $0.centerY.equalTo(self.backButtonIcon.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(UI.titleTopMargin)
            $0.width.equalTo(UI.titleWidth)
            $0.centerX.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(UI.containerTopMargin)
            $0.leading.equalToSuperview().offset(UI.containerLeadingMargin)
            $0.trailing.equalToSuperview().offset(UI.containerTrailingMargin)
            $0.height.equalTo(UI.containerHeight)
        }
        
        studentCardLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UI.studentCardTopMargin)
            $0.centerX.equalToSuperview()
        }
        
        chosenUserPhoto.snp.makeConstraints {
            $0.top.equalTo(studentCardLabel.snp.bottom).offset(UI.chosenUserPhotoTopMargin)
            $0.width.height.equalTo(UI.chosenUserPhotoSize)
            $0.centerX.equalToSuperview()
        }
        
        bottomContainerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(UI.bottomContainerHeight)
        }
        
        divisionView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(UI.divisionViewWidth)
            $0.height.equalTo(UI.divisionViewHeight)
        }
        
        usernameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(divisionView.snp.top).offset(UI.usernameBottomMargin)
        }
        
        positionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(divisionView.snp.bottom).offset(UI.positionTopMargin)
        }
        
        btnStackView.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(UI.btnStackViewTopMargin)
            $0.width.equalTo(UI.btnStackViewWidth)
            $0.height.equalTo(UI.btnStackViewHeight)
            $0.centerX.equalToSuperview()
        }
        

    }
    
}
