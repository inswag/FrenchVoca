//
//  SignInController.swift
//  FrenchVocaProject
//
//  Created by 박인수 on 22/12/2018.
//  Copyright © 2018 inswag. All rights reserved.
//

import UIKit

class SignInController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // France Blue RGB : 36 74 156
    let titleBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        let titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        let attributedTitle = NSAttributedString(string: "French Voca", attributes: [NSAttributedString.Key.font: UIFont(name: "Avenir-Light", size: 23)!, NSAttributedString.Key.foregroundColor: UIColor.black])
        titleLabel.attributedText = attributedTitle
        view.addSubview(titleLabel)
        
        titleLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 180, height: 50)
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return view
    }()
    
    let loginPhotoButton: UIButton = {
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            loginPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            loginPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        loginPhotoButton.layer.cornerRadius = loginPhotoButton.frame.width / 2
        loginPhotoButton.layer.masksToBounds = true
        loginPhotoButton.layer.borderColor = UIColor.black.cgColor
        loginPhotoButton.layer.borderWidth = 1
        
        dismiss(animated: true, completion: nil)
    }
    
    
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
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시작(Commencer)", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 199, green: 203, blue: 210)
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
//    let loginGuideTitle: UILabel = {
//        let label = UILabel()
//        label.text = "간단한 입력을 통해 시작하세요!"
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.adjustsFontSizeToFitWidth = true
//        label.textColor = UIColor.rgb(red: 36, green: 74, blue: 156)
//        label.textAlignment = .center
//        return label
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setLogoDesign()
        setupInputFields()
        
//        usernameTextField.becomeFirstResponder()
    }
    
    @objc func handleTextInputChange() {
        
        print("OK handleTextInputChange")
        let isFormVaild = usernameTextField.text?.isEmpty != true && positionTextField.text?.isEmpty != true
        
        if isFormVaild {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor.rgb(red: 36, green: 74, blue: 156)
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor.rgb(red: 199, green: 203, blue: 210)
        }
    }
    
    @objc func handleLogin() {
        print("OK handleLogin")
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController")
        self.dismiss(animated: true, completion: nil)
        
//        let viewController = SignUpController()
//        navigationController?.pushViewController(viewController, animated: true)
        
        //
        //        Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
        //            if let err = err {
        //                print("Failed to sign in with email:", err)
        //                return
        //            }
        //
        //            print("Successfully logged back in with user:", user?.user.uid ?? "")
        //
        //            guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
        //
        //            mainTabBarController.setupViewControllers()
        //
        //            // dismiss 가 completion block 내부에 있기 때문에 .self 를 붙여주어야 한다. 왜..?QQQQQ
        //            self.dismiss(animated: true, completion: nil)
        //        }
    }
    
    func setLogoDesign() {
        self.view.addSubview(titleBackgroundView)
        self.titleBackgroundView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
    }
    
    func setupInputFields() {
        self.view.addSubview(loginPhotoButton)
        loginPhotoButton.anchor(top: self.titleBackgroundView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        loginPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, positionTextField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        
        self.view.addSubview(stackView)
        // (each textField size 40 * 3) + (spacing 20 * 2)
        stackView.anchor(top: self.loginPhotoButton.bottomAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 40, paddingLeft: 60, paddingBottom: 0, paddingRight: 60, width: 0, height: 160)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
