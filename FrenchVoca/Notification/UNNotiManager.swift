//
//  UNNotiManager.swift
//  FrenchVoca
//
//  Created by 박인수 on 09/04/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UserNotifications
import UIKit

class UNNotiManager: NSObject {

    // MARK:- Properties
    
    var wordDAO = WordDAO()
    var totalWord: [WordVO]!
    var wordList: [WordVO]!
    
    // Save Time In UserDefaults
    let plist = UserDefaults.standard
    let center = UNUserNotificationCenter.current()
    
    // MARK:- Methods
    
    func register() {
        center.delegate = self                                                  // 2
        let options: UNAuthorizationOptions = [.alert, .sound]                  // 3
        center.requestAuthorization(options: options) { (granted, error) in   // 4

            if let error = error {
                print(error.localizedDescription)
            }
            guard granted else { return }
            print("\(granted)")
            self.setupNotificationActions()
        }
        
        
    }

    func getNotificationSettings(completionHandler: @escaping (Bool) -> Void) {
        center.getNotificationSettings { (settings) in
            
            
            if settings.authorizationStatus == .authorized {
                completionHandler(true)
            } else {
                print("denied")
                completionHandler(false)
            }
            
//            switch settings.authorizationStatus {
//            case .authorized:
//                completionHandler(settings.authorizationStatus == .authorized)
//            case .denied: // 유저가 허용하지 않음을 클릭했을 떄
//                print("denied")
//                completionHandler(false)
//            case .notDetermined:
//                print("notDetermined")
//            case .provisional:
//                print("provisional")
//            }
//                        settings.badgeSetting
            //            settings.alertSetting
            //            settings.soundSetting
            //            settings.alertStyle
        }
    }
    
    
    
    func triggerTimeIntervalNotification(time: Double) {
        let content = UNMutableNotificationContent()

        self.totalWord = self.wordDAO.findTotalWord()
        let randomNumber = Int(arc4random_uniform(UInt32(self.totalWord.count)))
        self.wordList = self.wordDAO.findForNoti(randomNumber: randomNumber)
        
        content.title = "단어 : \(self.wordList[0].wordTitle)"
        content.subtitle = "\(self.wordList[0].wordPartOfSpeech) \(self.wordList[0].wordGender) \(self.wordList[0].wordNumber) \(self.wordList[0].wordMeaning)"
        content.body = "알림을 밀어 '다음 단어'를 터치하세요"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "CategoryID"

        // 유저의 선택에 따라 선택되도록 !
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: true)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false) // Test용
        print("trigger will go")

        // identifier? 알림요청이 여러가지가 될 때, 이 알림들을 구분할 수 있게 해주는 식별자
        let request = UNNotificationRequest(identifier: "motdujour", content: content, trigger: trigger)

        center.add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
                print("triggerTimeIntervalNotification 에서 Error 가 발견되었습니다.")
            }
        }
    }

    func setupNotificationActions() {
        let destructiveAction = UNNotificationAction(identifier: "DESID",
                                                     title: "다음 단어",
                                                     options: [.destructive])

        // iOS 10+
        let category = UNNotificationCategory(
            identifier: "CategoryID",
            actions: [destructiveAction],
            intentIdentifiers: [],
            options: []
        )

        center.setNotificationCategories([category])
    }

}

// MARK:- UNUserNotificationCenter Delegate

extension UNNotiManager: UNUserNotificationCenterDelegate {

    // 앱이 백그라운드 혹은 종료 상태 에는 여기로 응답이 들어오게 되고,
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print("-------[ didReceive ] -------")
        
        // 21.
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            print("Default")
//            self.triggerTimeIntervalNotification()
        case UNNotificationDismissActionIdentifier: // 22 참고
            print("Dismiss")
//            self.triggerTimeIntervalNotification()
        case "FOREID":
            print("Foreground Action")
        case "INPUTID": // 23.
//            if let response = response as? UNTextInputNotificationResponse {
//                print(response.userText)
                print("INPUT ACTION")
//            }
//            self.triggerTimeIntervalNotification()
        default:
            print("Unknown Action")
            self.triggerTimeIntervalNotification(time: plist.double(forKey: "알림시간"))
        }

        completionHandler() // 24. 이것만 처리해주면 됌 아래와는 다르게
    }

    // Foreground 에서 Noti를 받을 때 들어오는 메서드
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("-------[ willPresent ] -------")
        print(notification)
        //        if notification.request.content.categoryIdentifier == "identifier" {
        completionHandler([.alert, .sound])
        //        }
    }




}
