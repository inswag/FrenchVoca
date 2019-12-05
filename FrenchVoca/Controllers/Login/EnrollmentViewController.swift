//
//  EnrollmentViewController.swift
//  FrenchVoca
//
//  Created by 박인수 on 17/02/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class EnrollmentViewController: UIViewController, UITextFieldDelegate {
    
    var image: UIImage?
    
    // Title View
    let titleBackgroundView: UIView = {
        // France Blue RGB : 36 74 156
        let view = UIView()
        view.backgroundColor = UIColor.white
        let titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = "등록\n(Inscription)"
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "Avenir-Light", size: 23)
//        let attributedTitle = NSAttributedString(string: "등록\n(Inscription)", attributes: [NSAttributedString.Key.font: UIFont(name: "Avenir-Light", size: 23)!, NSAttributedString.Key.foregroundColor: UIColor.black])
//        titleLabel.attributedText = attributedTitle
        view.addSubview(titleLabel)
        
        titleLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 80)
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return view
    }()
    
    // User Photo Button
    let userPhotoButton: UIButton = {
        // Button.ButtonType.system : A system style button, such as those shown in navigation bars and toolbars. <-> '.custom'
        let button = UIButton(type: .system)
        let image = UIImage(named: "login_Photos")
        // UIImageRenderingModeAlwaysOriginal : Always draw the original image, without treating it as a template.
        // UIImageRenderingModeAlwaysTemplate : Always draw the image as a template image, ignoring its color information.
        image?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        return button
    }()
    
    @objc func handlePlusPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    // Username & Position & Next Button
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임(Votre surnom)"
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
    }()
    
    let positionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "소속(Votre position)"
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("다음(Suivant)", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.rgb(red: 199, green: 203, blue: 210)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    @objc func handleTextInputChange() {
        let isFormVaild = usernameTextField.text?.isEmpty != true && positionTextField.text?.isEmpty != true
        
        if isFormVaild {
            nextButton.isEnabled = true
            nextButton.backgroundColor = UIColor.rgb(red: 36, green: 74, blue: 156)
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = UIColor.rgb(red: 199, green: 203, blue: 210)
        }
    }
    
    @objc func handleNext() {
        print("OK handleNext")
        // 여기서 값을 넘겨주는 것을 해야함.
        let signInViewController = SignInViewController()
        signInViewController.usernameLabel.text = self.usernameTextField.text
        signInViewController.positionLabel.text = self.positionTextField.text
        signInViewController.chosenUserPhoto.image = self.image?.withRenderingMode(.alwaysOriginal)
        
        self.view.endEditing(true)
        navigationController?.pushViewController(signInViewController, animated: true)
    }
    
    
    // MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUIDesign()
        setupInputFields()
        //        usernameTextField.becomeFirstResponder()
    }
    
    // MARK:- Design
    func setupUIDesign() {
        self.navigationController?.isNavigationBarHidden = true
        self.view.addSubview(titleBackgroundView)
        self.titleBackgroundView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: self.view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
    }
    
    func setupInputFields() {
        self.view.addSubview(userPhotoButton)
        userPhotoButton.anchor(top: self.titleBackgroundView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        userPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, positionTextField, nextButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        
        self.view.addSubview(stackView)
        // (each textField size 40 * 3) + (spacing 20 * 2)
        stackView.anchor(top: self.userPhotoButton.bottomAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: self.view.safeAreaLayoutGuide.rightAnchor, paddingTop: 40, paddingLeft: 60, paddingBottom: 0, paddingRight: 60, width: 0, height: 160)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension EnrollmentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            userPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
            self.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        userPhotoButton.layer.cornerRadius = userPhotoButton.frame.width / 2
        userPhotoButton.layer.masksToBounds = true
        userPhotoButton.layer.borderColor = UIColor.black.cgColor
        userPhotoButton.layer.borderWidth = 0
        dismiss(animated: true, completion: nil)
    }
    
}
