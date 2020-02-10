//
//  SettingDefaultCell.swift
//  FrenchVoca
//
//  Created by 박인수 on 18/11/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit
import UserNotifications

class SettingSwitchCell: UITableViewCell {
    
    static func defineCellHeight() -> CGFloat {
        let cellHeight = (Constant.titleFont.lineHeight) + (Constant.margin) + (Constant.subTitleFont.lineHeight)
        return cellHeight
    }
    
    struct Constant {
        static let margin: CGFloat = 16
        static let titleFont = Tools.font.avenirLight(size: 18)
        static let subTitleFont = Tools.font.avenirLight(size: 12)
    }
    
    // MARK:- Properties
    
    let notiManager = UNNotiManager()
    let plist = UserDefaults.standard
    
    // MARK:- UI Properties
    
    // Left Side
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textAlignment = .left
        label.font = Constant.titleFont
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "subtitle"
        label.textAlignment = .left
        label.font = Constant.subTitleFont
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    // Right Side
    lazy var controlSwitch: UISwitch = {
        let interrupteur = UISwitch()
        interrupteur.tintColor = Tools.color.frenchBlue // Set Switch to On.
        interrupteur.isOn = plist.bool(forKey: "알림설정확인") // Set the event to be called when switching On / Off of Switch.
        
        interrupteur.addTarget(self, action: #selector(touchAction), for: UIControl.Event.valueChanged)
        return interrupteur
        
    }()
    
    
    
    // 치명적 오류 존재
    @objc func touchAction() {
        print("Toggle switch")
        if self.controlSwitch.isOn {
            
            // Authentification of Noti
//            notiManager.register()
            notiManager.getNotificationSettings { isAuthorized in
                guard  isAuthorized else { return }
            }
            print("Toggle plist value : \(plist.double(forKey: "알림시간"))")
            notiManager.triggerTimeIntervalNotification(time: plist.double(forKey: "알림시간"))
            
            // Toggle's state
            self.controlSwitch.isOn = true
            plist.set(true, forKey: "알림설정확인")
            plist.synchronize()
        } else {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            self.controlSwitch.isOn = false
            plist.set(false, forKey: "알림설정확인")
            plist.synchronize()
        }
        
    }
    
    // MARK:- Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: String(describing: SettingViewController.self))
        self.setupUIComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- UI Methods
    
    func setupUIComponents() {
        [titleLabel, subTitleLabel, controlSwitch].forEach { self.contentView.addSubview($0) }
        
        self.titleLabel.anchor(top: self.contentView.topAnchor,
                               left: self.contentView.leftAnchor,
                               bottom: nil,
                               right: self.contentView.rightAnchor,
                               paddingTop: 8,
                               paddingLeft: 24,
                               paddingBottom: 0,
                               paddingRight: 24,
                               width: 0,
                               height: 0)
        
        self.subTitleLabel.anchor(top: self.titleLabel.bottomAnchor,
                                  left: self.contentView.leftAnchor,
                                  bottom: nil,
                                  right: self.rightAnchor,
                                  paddingTop: 0,
                                  paddingLeft: 24,
                                  paddingBottom: 8,
                                  paddingRight: 24,
                                  width: 0,
                                  height: 0)
        
        self.controlSwitch.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.controlSwitch.anchor(top: nil,
                                  left: nil,
                                  bottom: nil,
                                  right: self.contentView.rightAnchor,
                                  paddingTop: 0,
                                  paddingLeft: 0,
                                  paddingBottom: 0,
                                  paddingRight: 20,
                                  width: 0,
                                  height: 0)
    }
    
    
    
}
