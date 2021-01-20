//
//  AppDelegate.swift
//  BrazeSDKIntegration
//
//  Created by Nigel Faustino on 11/24/20.
//

import UIKit
import AppboyKit
import UserNotificationsUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Appboy.start(withApiKey: "fc5dd8a8-83fe-4941-bbeb-1f82dd64250d", in:application, withLaunchOptions:launchOptions)
        if #available(iOS 10, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            var options: UNAuthorizationOptions = [.alert, .sound, .badge]
            if #available(iOS 12.0, *) {
                options = UNAuthorizationOptions(rawValue: options.rawValue | UNAuthorizationOptions.provisional.rawValue)
            }
            center.requestAuthorization(options: options) { (granted, error) in
                Appboy.sharedInstance()?.pushAuthorization(fromUserNotificationCenter: granted)
            }
            UIApplication.shared.registerForRemoteNotifications()
        } else {
            let types : UIUserNotificationType = [.alert, .badge, .sound]
            let setting : UIUserNotificationSettings = UIUserNotificationSettings(types:types, categories:nil)
            UIApplication.shared.registerUserNotificationSettings(setting)
            UIApplication.shared.registerForRemoteNotifications()
        }

        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber =
          Appboy.sharedInstance()?.contentCardsController.unviewedContentCardCount() ?? 0
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Appboy.sharedInstance()?.registerDeviceToken(deviceToken)
        print(deviceToken.base64EncodedString())
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Appboy.sharedInstance()?.register(application,
                                                    didReceiveRemoteNotification: userInfo,
                                                    fetchCompletionHandler: completionHandler)
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
      Appboy.sharedInstance()?.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                    willPresent notification: UNNotification,
          withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([UNNotificationPresentationOptions.sound, UNNotificationPresentationOptions.badge, UNNotificationPresentationOptions.banner])
    }





    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

