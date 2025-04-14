//
//  AppDelegate.swift
//  MSWalkMemoryPractice
//
//  Created by 강민수 on 3/17/25.
//

import UIKit
import FirebaseCore
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        
        application.registerForRemoteNotifications()
        
        // 메시지 대리자 설정
        Messaging.messaging().delegate = self
        
        // 현재 갱신 토큰 가져오기.
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("FCM registration token: \(token)")
          }
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
}

extension AppDelegate: MessagingDelegate {
    
    // 토큰 갱신 모니터링
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}

// UNUserNotificationCenterDelegate
// 사용자 클릭 처리: 알림이 전달 되었는지는 알 수 없다. (사용자가 클릭했던 것에 대한 시점만 알 수 있다)
// 특정 화면에서 푸시 안받기 (포그라운드에서 알림이 안오는게 Default)
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // 포그라운드에 해당
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print(notification)
        print(notification.request.content.title)
        print(notification.request.content.userInfo)
        
        // 특정화면에서는 푸시가 안뜨게 가능
        guard let user = notification.request.content.userInfo["chat"] as? String else {
            return
        }
        
        completionHandler([.list, .badge, .badge, .sound])
    }
    
    // 푸시 클릭 시
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response.notification)
        print(response.notification.request.content.title)
        print(response.notification.request.content.userInfo)
        
        guard let ad = response.notification.request.content.userInfo["ad"] as? Bool else {
            return
        }
        
        if ad {
            // 광고로 이동
        }
        
        guard let user = response.notification.request.content.userInfo["chat"] as? String else {
            return
        }
    }
    
    // 앱을 제거하고 다시 다운 받으니 디바이스 토큰의 값이 바뀌었다.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", { $0 + String(format: "%02X", $1) })
        print("deviceToken:\(deviceTokenString)")
        
        Messaging.messaging().apnsToken = deviceToken
    }
}
//     이전까지 배운 내용들
//     특정화면에서 알림 안받기.. 받기 등등..?
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
//        <#code#>
//    }
//    
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
//        <#code#>
//    }
//}
//deviceToken:80985D80093B98BA4226909BEC426199F3CE24C386AB4F94EDC73A18B1ADC15713C81F387A2B01A86E9CDED664C7F41422726DEBDB8D00DE596C9EB003A2F3EE3CB86F91F0B9BC2BA6BC43F18AD7CEB9
//deviceToken:80985D80093B98BA4226909BEC426199F3CE24C386AB4F94EDC73A18B1ADC15713C81F387A2B01A86E9CDED664C7F41422726DEBDB8D00DE596C9EB003A2F3EE3CB86F91F0B9BC2BA6BC43F18AD7CEB9
