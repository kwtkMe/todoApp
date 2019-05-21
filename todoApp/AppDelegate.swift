//
//  AppDelegate.swift
//  todoApp
//
//  Created by RIVER on 2019/04/27.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    override init() {
        super.init()
        // Firebaseの認証に関する設定
        FirebaseApp.configure()
        startTwitterInstanceShare()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 画面に関する設定
        let taskViewVC = UIStoryboard(
            name: "TaskView",
            bundle: nil)
            .instantiateViewController(withIdentifier: "initial") as! TaskViewViewController
        let navigationController = UINavigationController(rootViewController: taskViewVC)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func startTwitterInstanceShare() {
        guard let API_KEY = KeyManager().getValue(key: "TWITTER_API_KEY") as? String else {
            print("Twitter API EROOR")
            return
        }
        guard let API_SECRET_KEY = KeyManager().getValue(key: "TWITTER_API_SECRET_KEY") as? String else {
            print("Twitter API_SECRET EROOR")
            return
        }
        TWTRTwitter.sharedInstance().start(withConsumerKey: API_KEY,
                                           consumerSecret: API_SECRET_KEY)
    }
    
    // facebook or Google
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        // Google or Facebook認証、trueを返す
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        
        return false
    }

}
    

