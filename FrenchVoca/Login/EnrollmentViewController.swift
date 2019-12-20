//
//  EnrollmentViewController.swift
//  FrenchVoca
//
//  Created by 박인수 on 17/02/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit
import SnapKit

class EnrollmentViewController: UIViewController {
    
    // MARK: UI Properties
    var image: UIImage?
    
    let enrollmentTitle : UILabel = {
        // France Blue RGB : 36 74 156
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = "등록\n(Inscription)"
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "Avenir-Light", size: 23)
        return titleLabel
    }()
    
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
    
    // Username & Position & Next Button will be made by Stackview
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임(Votre surnom)"
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.delegate = self
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
    }()
    
    lazy var positionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "소속(Votre position)"
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.delegate = self
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
        let signInViewController = SignInViewController()
        signInViewController.usernameLabel.text = self.usernameTextField.text
        signInViewController.positionLabel.text = self.positionTextField.text
        signInViewController.chosenUserPhoto.image = self.image?.withRenderingMode(.alwaysOriginal)
        
        self.view.endEditing(true)
        navigationController?.pushViewController(signInViewController, animated: true)
    }
    
    let descriptionView: UIView = {
        let view = UIView() // 110/27
        let label = UILabel()
        view.addSubview(label)
        view.backgroundColor = UIColor.rgb(red: 246, green: 246, blue: 250)
        view.layer.cornerRadius = 15
        label.text = "닉네임과 소속은 자유롭게 적어주세요 :)"
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Light", size: 12.0)
        label.textColor = UIColor.rgb(red: 163, green: 163, blue: 181)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.snp.makeConstraints { (m) in
            m.centerX.equalTo(view.snp.centerX)
            m.centerY.equalTo(view.snp.centerY)
        }
        return view
    }()
    
    // MARK:- View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.restoreFrameValue = self.view.frame.origin.y
        self.view.backgroundColor = .white
        setupUIComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    
    // MARK:- UI Components
    func setupUIComponents() {
        
        self.navigationController?.isNavigationBarHidden = true
        [enrollmentTitle, userPhotoButton, descriptionView].forEach { self.view.addSubview($0) }
        
        self.enrollmentTitle.snp.makeConstraints { (m) in
            m.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            m.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            m.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            m.height.equalTo(200)
        }
        
        self.userPhotoButton.snp.makeConstraints { (m) in
            m.top.equalTo(self.enrollmentTitle.snp.bottom)
            m.width.equalTo(100)
            m.height.equalTo(100)
            m.centerX.equalTo(self.view.snp.centerX)
        }

        self.descriptionView.snp.makeConstraints { (m) in
            m.top.equalTo(self.userPhotoButton.snp.bottom).offset(40)
            m.leading.equalToSuperview().offset(70)
            m.trailing.equalToSuperview().offset(-70)
            m.height.equalTo(30)
        }
        
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, positionTextField, nextButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints { (m) in
            m.top.equalTo(self.descriptionView.snp.bottom).offset(20)
            m.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(60)
            m.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-60)
            m.height.equalTo(160)
        }
        
    }
    
    var restoreFrameValue: CGFloat = 0.0
    
}

// MARK: TextField & Keyboard Methods
extension EnrollmentViewController: UITextFieldDelegate {
    
    @objc func keyboardWillAppear(noti: NSNotification) {
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y -= keyboardHeight
        }
        print("keyboard Will appear Execute")
    }
    
    @objc func keyboardWillDisappear(noti: NSNotification) {
        if self.view.frame.origin.y != restoreFrameValue {
            if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                self.view.frame.origin.y += keyboardHeight
            }
            print("keyboard Will Disappear Execute")
        }
    }
    
    //self.view.frame.origin.y = restoreFrameValue
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.frame.origin.y = restoreFrameValue
        print("touches Began Execute")
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn Execute")
        textField.resignFirstResponder()
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing Execute")
        self.view.frame.origin.y = self.restoreFrameValue
        return true
    }
    
}

// MARK: Image Picker Methods
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
