//
//  VocabularyVoiceSettingVC.swift
//  FrenchVoca
//
//  Created by 박인수 on 19/11/2019.
//  Copyright © 2019 inswag. All rights reserved.
//


import AVFoundation
import UIKit
import SnapKit

class VocabularyVoiceSettingVC: UIViewController {
    
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
        let attributedTitle = NSAttributedString(string: "Arrière",
                                                 attributes: [NSAttributedString.Key.font: Tools.font.avenirLight(size: 20),
                                                              NSAttributedString.Key.foregroundColor: Tools.color.lightBlack])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handlePopAction), for: .touchUpInside)
        return button
    }()
    
    @objc func handlePopAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Title Label
    let titleLabel: UILabel = {
        // France Blue RGB : 36 74 156
        let titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.white
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        titleLabel.text = "발음 속도 조절"
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
        label.text = "(Réglage de la vitesse de prononciation)"
        label.font = Tools.font.avenirBlack(size: 17)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let commentLabel: UILabel = {
           // France Blue RGB : 36 74 156
           let label = UILabel()
           label.backgroundColor = UIColor.white
           label.textAlignment = .left
           label.numberOfLines = 1
           label.text = "* 아래에서 속도를 조절하고 예문을 들어보세요!"
           label.font = Tools.font.avenirLight(size: 11)
           label.adjustsFontSizeToFitWidth = true
           return label
    }()
    
    let commentExampleLabel: UILabel = {
        // France Blue RGB : 36 74 156
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Bonjour! Je m'appelle Antoine."
        label.font = Tools.font.avenirLight(size: 14)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
   
    let plist = UserDefaults.standard
    
    //  UISilder
    let rateSlider: UISlider = {
        let slider = UISlider()
        slider.backgroundColor = UIColor.white
        
        slider.minimumValue = AVSpeechUtteranceMinimumSpeechRate // TTS Minimum 0.0
        slider.maximumValue = AVSpeechUtteranceMaximumSpeechRate - 0.4 // TTS Maximum 1.0
        
        let plist = UserDefaults.standard
        if plist.float(forKey: "발음속도") == 0.0 {
            slider.value = AVSpeechUtteranceDefaultSpeechRate
        } else {
            slider.value = plist.float(forKey: "발음속도")
        }

        slider.minimumValueImage = UIImage(named: "turtleSlow")
        slider.maximumValueImage = UIImage(named: "rabbitFast")
        
        slider.addTarget(self, action: #selector(handleRateChange), for: .valueChanged) // .valueChanged : 값의 변화를 추적
        return slider
    }()

    var willPassValue: Float = 0.5
    
    @objc func handleRateChange() {
        willPassValue = rateSlider.value
        print("\(rateSlider.value)")
    }
    
    // Button Stack View
    let previewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("들어보기\n(Aperçu)", for: .normal)
        button.backgroundColor = Tools.color.frenchBlue // BLUE
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel!.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(handlePreview), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()
    
    let synthesizer = AVSpeechSynthesizer()
    
    @objc func handlePreview() {
        let utterance = AVSpeechUtterance(string: self.commentExampleLabel.text!)
        utterance.voice = AVSpeechSynthesisVoice(language: "fr-FR")
        utterance.rate = self.rateSlider.value
        synthesizer.speak(utterance)
        
        print("Preview OK")
    }
    
    let defaultValueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("기본값\n(par défaut)", for: .normal)
        button.backgroundColor = Tools.color.frenchRed
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel!.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(handleDefaultValue), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()
    
    @objc func handleDefaultValue() {
        self.rateSlider.value = 0.5
        self.willPassValue = self.rateSlider.value
        print("handleDefaultValue Setting OK")
        
    }
    
    
    let settingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("설정\n(Mettez en place)", for: .normal)
        button.backgroundColor = Tools.color.sandYellow // SAND
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel!.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(handleSetting), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()
    
    @objc func handleSetting() {
        let plist = UserDefaults.standard
        plist.set(self.willPassValue, forKey: "발음속도")
        plist.synchronize()
        print("Prononciation Setting OK")
        
        // 메인 뷰 진입
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        setupUIDesign()
    }
    
    // MARK:- UI Design
    func setupUIDesign() {
        
        [rateSlider, backButtonIcon, backButtonText].forEach { self.view.addSubview($0) }
        
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

        [labelStackView, commentLabel, commentExampleLabel].forEach { self.view.addSubview($0) }
        
        let textHeight = titleLabel.font.lineHeight + subtitleLabel.font.lineHeight + 3

        labelStackView.snp.makeConstraints { (m) in
            m.top.equalTo(backButtonIcon.snp.bottom).offset(40)
            m.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(40)
            m.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).offset(-40)
            m.height.equalTo(textHeight)
        }
        
        commentLabel.snp.makeConstraints { (m) in
            m.top.equalTo(labelStackView.snp.bottom).offset(3)
            m.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(40)
            m.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).offset(-40)
        }

        commentExampleLabel.snp.makeConstraints { (m) in
            m.top.equalTo(commentLabel.snp.bottom).offset(25)
            m.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(40)
            m.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).offset(-40)
        }
        
        rateSlider.snp.makeConstraints { (m) in
            m.top.equalTo(commentExampleLabel.snp.bottom).offset(25)
            m.leading.equalTo(self.view.snp.leadingMargin).offset(40)
            m.trailing.equalTo(self.view.snp.trailingMargin).offset(-40)
            m.height.equalTo(50)
        }
        
        // UIStackView - Button
        let btnStackView = UIStackView(arrangedSubviews: [previewButton, defaultValueButton])
        btnStackView.axis = .horizontal
        btnStackView.spacing = 20
        btnStackView.distribution = .fillEqually
        
        let containerStackView = UIStackView(arrangedSubviews: [btnStackView, settingButton])
        containerStackView.axis = .vertical
        containerStackView.spacing = 20
        containerStackView.distribution = .fillEqually
        
        [containerStackView].forEach { self.view.addSubview($0) }
        
        containerStackView.snp.makeConstraints { (m) in
            m.top.equalTo(rateSlider.snp.bottom).offset(30)

            m.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(40)
            m.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).offset(-40)
            m.height.equalTo(100)
        }
    
    }
    
    deinit {
        if synthesizer.isSpeaking == true {
            synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        }
    }
    
}
