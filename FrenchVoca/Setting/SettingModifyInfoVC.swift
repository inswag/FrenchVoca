//
//  SettingModifyInfoVC.swift
//  FrenchVoca
//
//  Created by 박인수 on 05/04/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class SettingModifyInfoVC: UIViewController {
    
    // MARK:- Properties
    
    var newImage = UIImage(named: "D")
    let imagePickerControllerInSettingVC = UIImagePickerController()
    
    // MARK:- UI Properties
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = .white
        view.layer.cornerRadius = 3
        return view
    }()
    
    // MARK:- 'now' Property
    
    let nowTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Maintenant(현재)"
        label.textAlignment = .left
        label.font = Tools.font.avenirBook(size: 14)
        label.textColor = Tools.color.prettyBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let nowContainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = Tools.color.prettyGray.cgColor
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    let nowStudentCardLabel: UILabel = {
        let label = UILabel()
        let underlineAttriString = NSAttributedString(string: "Carte d'étudiant",
                                                      attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                                                                   NSAttributedString.Key.font: Tools.font.avenirLight(size: 14),
                                                                   NSAttributedString.Key.foregroundColor: Tools.color.lightBlack])
        label.attributedText = underlineAttriString
        return label
    }()
    
    let nowProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30 // imageView Size 60 * 60
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nowUsernameLabel: UILabel = {
        let label = UILabel()
        label.text = "VOTRE SURNOM"
        label.textAlignment = .left
        label.font = Tools.font.avenirBlack(size: 20)
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let nowPositionLabel: UILabel = {
        let label = UILabel()
        label.text = "Votre position"
        label.textAlignment = .left
        label.font = Tools.font.avenirBook(size: 15)
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // MARK:- 'after' Property
    let afterTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Après(수정 후)"
        label.textAlignment = .left
        label.font = Tools.font.avenirBook(size: 14)
        label.textColor = Tools.color.prettyBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let afterContainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = Tools.color.prettyGray.cgColor
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    let afterStudentCardLabel: UILabel = {
        let label = UILabel()
        label.font = Tools.font.avenirLight(size: 14)
        let underlineAttriString = NSAttributedString(string: "Carte d'étudiant",
                                                      attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                                                                   NSAttributedString.Key.font: Tools.font.avenirLight(size: 14),
                                                                   NSAttributedString.Key.foregroundColor: Tools.color.lightBlack])
        label.attributedText = underlineAttriString
        return label
    }()
    
    lazy var afterProfileImageButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .lightGray
        btn.setTitle("+", for: .normal)
        btn.layer.cornerRadius = 30 // Size 60 * 60
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(handlePickImage), for: .touchUpInside)
        return btn
    }()
    
    @objc func handlePickImage() {
        print("Push")
        self.present(imagePickerControllerInSettingVC, animated: true, completion: nil)
    }
    
    let afterUsernameTextfield: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Votre surnom"
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .roundedRect
        textField.font = Tools.font.avenirBlack(size: 20)
        textField.textColor = Tools.color.lightBlack
        textField.addTarget(self, action: #selector(handleInputChange), for: .editingChanged)
        return textField
    }()
    
    let afterPositionTextfield: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Votre position"
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .roundedRect
        textField.font = Tools.font.avenirBook(size: 15)
        textField.textColor = Tools.color.lightBlack
        textField.addTarget(self, action: #selector(handleInputChange), for: .editingChanged)
        return textField
    }()
    
    @objc func handleInputChange() {
        // Handling UX Design
        self.completeButton.isEnabled = false
        self.completeButton.backgroundColor = Tools.color.darkGray
        self.saveButton.isEnabled = true
        self.saveButton.backgroundColor = Tools.color.frenchBlue
    }
    
    //MARK:- 'button' Property
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Tools.color.frenchRed
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()
    
    @objc func handleCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("저장", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Tools.color.frenchBlue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()
    
    @objc func handleSave() {
        print("handleSave")
        
        // Handling UX Design
        self.completeButton.isEnabled = true
        self.completeButton.backgroundColor = Tools.color.frenchBlue
        self.saveButton.isEnabled = false
        self.saveButton.backgroundColor = Tools.color.darkGray
        
        print("handleSave")
    }
    
    lazy var completeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Tools.color.darkGray
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleComplete), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    @objc func handleComplete() {
        print("Handle Complete")
        if self.afterUsernameTextfield.text?.isEmpty != true && self.afterPositionTextfield.text?.isEmpty != true {
            let plist = UserDefaults.standard
            plist.set(self.afterUsernameTextfield.text, forKey: "이름")
            plist.set(self.afterPositionTextfield.text, forKey: "소속")
            if let imageData = self.newImage?.jpegData(compressionQuality: 0.3) {
                plist.set(imageData, forKey: "이미지")
            }
            plist.synchronize()
            
//            let setting = SettingViewController(navigator: Navigator())
//            setting.tableview.reloadData()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    let noticeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "* 앱 재실행 시 반영됩니다 :)"
        label.textAlignment = .left
        label.font = Tools.font.avenirBook(size: 14)
        label.textColor = Tools.color.prettyBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIComponents()
        setupContainer()
        print("View Did Load OK")
    }
    
    // MARK:- Methods
    
    fileprivate func setupContainer() {
        let plist = UserDefaults.standard
        self.nowUsernameLabel.text = plist.string(forKey: "이름")
        self.nowPositionLabel.text = plist.string(forKey: "소속")
        if let imageData = plist.data(forKey: "이미지") {
            self.nowProfileImageView.image = UIImage(data: imageData)
        }
        
        self.afterUsernameTextfield.text = plist.string(forKey: "이름")
        self.afterPositionTextfield.text = plist.string(forKey: "소속")
    }
    
    // MARK:- UI Methods
    
    fileprivate func setupUIComponents() {
        imagePickerControllerInSettingVC.delegate = self
        imagePickerControllerInSettingVC.allowsEditing = true
        imagePickerControllerInSettingVC.sourceType = .photoLibrary
        
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false
        
        let buttonStackView = UIStackView(arrangedSubviews: [cancelButton, saveButton, completeButton])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 10
        buttonStackView.distribution = .fillEqually
        
        [containerView, buttonStackView].forEach {
            self.view.addSubview($0)
        }
        
        self.containerView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                                  left: nil,
                                  bottom: nil,
                                  right: nil,
                                  paddingTop: 30,
                                  paddingLeft: 0,
                                  paddingBottom: 0,
                                  paddingRight: 0,
                                  width: 295,
                                  height: 410)
        self.containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        
        
        [nowTitleLabel, nowContainerView, afterTitleLabel, afterContainerView, noticeTitleLabel].forEach {
            self.containerView.addSubview($0)
        }
        self.nowTitleLabel.anchor(top: self.containerView.topAnchor, left: self.containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        self.nowContainerView.anchor(top: self.nowTitleLabel.bottomAnchor, left: self.containerView.leftAnchor, bottom: nil, right: self.containerView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 275, height: 125)
        self.afterTitleLabel.anchor(top: self.nowContainerView.bottomAnchor, left: self.containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        self.afterContainerView.anchor(top: self.afterTitleLabel.bottomAnchor, left: self.containerView.leftAnchor, bottom: nil, right: self.containerView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 275, height: 125)
        buttonStackView.anchor(top: self.afterContainerView.bottomAnchor, left: self.containerView.leftAnchor, bottom: nil, right: self.containerView.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 275, height: 40)
        
        [nowStudentCardLabel, nowProfileImageView, nowUsernameLabel, nowPositionLabel].forEach { self.nowContainerView.addSubview($0) }
        self.nowStudentCardLabel.anchor(top: self.nowContainerView.topAnchor, left: self.nowContainerView.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        self.nowProfileImageView.anchor(top: self.nowStudentCardLabel.bottomAnchor, left: self.nowContainerView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        self.nowUsernameLabel.anchor(top: self.nowProfileImageView.topAnchor, left: self.nowProfileImageView.rightAnchor, bottom: nil, right: self.nowContainerView.rightAnchor, paddingTop: 5, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
        self.nowPositionLabel.anchor(top: nil, left: self.nowProfileImageView.rightAnchor, bottom: self.nowProfileImageView.bottomAnchor, right: self.nowContainerView.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 5, paddingRight: 15, width: 0, height: 0)
        
        [afterStudentCardLabel, afterProfileImageButton, afterUsernameTextfield, afterPositionTextfield].forEach { self.afterContainerView.addSubview($0) }
        self.afterStudentCardLabel.anchor(top: self.afterContainerView.topAnchor, left: self.afterContainerView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        self.afterProfileImageButton.anchor(top: self.afterStudentCardLabel.bottomAnchor, left: self.afterContainerView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        self.afterUsernameTextfield.anchor(top: self.afterProfileImageButton.topAnchor, left: self.afterProfileImageButton.rightAnchor, bottom: nil, right: self.afterContainerView.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
        self.afterPositionTextfield.anchor(top: self.afterUsernameTextfield.bottomAnchor, left: self.afterProfileImageButton.rightAnchor, bottom: nil, right: self.afterContainerView.rightAnchor, paddingTop: 5, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
        
        self.noticeTitleLabel.anchor(top: self.containerView.bottomAnchor, left: self.containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    git 
}

// MARK:- Image Picker Delegate

extension SettingModifyInfoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Picker")
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.afterProfileImageButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
            self.newImage = editedImage.withRenderingMode(.alwaysOriginal)
            
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.afterProfileImageButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
        
        imagePickerControllerInSettingVC.dismiss(animated: true, completion: nil)
        
        //ofileImageButton.layer.cornerRadius = userPhotoButton.frame.width / 2
        //        afterProfileImageButton.layer.masksToBounds = true
        //        afterProfileImageButton.layer.borderColor = UIColor.black.cgColor
        //        afterProfileImageButton.layer.borderWidth = 0
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickerControllerInSettingVC.dismiss(animated: false, completion: nil)
    }
}
