//
//  OneOnOneApp.swift
//  OneOnOne
//
//  Created by Vlad on 3/10/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct OneOnOneApp: App {
    // MARK: - Properties
    @StateObject var themeManager = ThemeManager()
    @StateObject var authModel = AuthScreenModel()
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            Group {
                if authModel.isAuthenticated {
                    MainTabView()
                } else if authModel.isVerificationSent {
                    ConfirmVerifyCodeView()
                } else {
                    SendVerificationCodeView()
                }
            }
            .environmentObject(authModel)
            .environmentObject(themeManager)
            .preferredColorScheme(themeManager.toggleDarkMode ? .dark : .light)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
    
    /*
     Передается токен устройства deviceToken в Firebase для работы с push-уведомлениями, с помощью метода Auth.auth().setAPNSToken().
     The device token is passed to Firebase for use with push notifications, using the Auth.auth().setAPNSToken() method.
     */
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Auth.auth().setAPNSToken(deviceToken, type: .unknown)
        print("Device token received: \(deviceToken.map { String(format: "%02x", $0) }.joined())")
    }
    
    /*
     Этот метод используется для обработки уведомлений, связанных с аутентификацией Firebase. Если уведомление не связано с Firebase Auth, оно должно быть обработано в других частях кода.
     This method is used to handle authentication-related notifications. If the notification is not related to Firebase Auth, it should be handled elsewhere in the code.
     */
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification notification: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if Auth.auth().canHandleNotification(notification) {
            completionHandler(.noData)
            return
        }
        // This notification is not auth related; it should be handled separately.
    }
    
    /*
     Передается URL для обработки URL-адреса, связанного с Firebase Auth. Если URL не связан с Firebase Auth, возвращается false.
     The URL is passed to handle the URL address associated with Firebase Auth. If the URL is not associated with Firebase Auth, it returns false.
     */
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if Auth.auth().canHandle(url) {
            return true
        } else {
            return false
        }
        
    }
}
