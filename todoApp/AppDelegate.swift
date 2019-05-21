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
    
    // 認証に使用するプロバイダの選択
    let providers: [FUIAuthProvider] = [
        FUITwitterAuth(),
        FUIGoogleAuth()
    ]
    
    // Firebase認証のログイン状態についてのハンドラ
    var handler = Auth.auth()
    // NotificationCenter
    let notification = NotificationCenter.default
    
    deinit {
        notification.removeObserver(self)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Firebaseの認証に関する設定
        configureFirebase()
        
        // 画面に関する設定
        let taskViewVC = UIStoryboard(
            name: "TaskView",
            bundle: nil)
            .instantiateViewController(withIdentifier: "view") as! TaskViewViewController
        let navigationController = UINavigationController(rootViewController: taskViewVC)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}

// Firebaseに関係するメソッド
extension AppDelegate {
    private func configureFirebase() {
        FirebaseApp.configure()
        startTwitterInstanceShare()
        configureFirebaseUI()
    }
    
    private func startTwitterInstanceShare() {
        guard let API_KEY = KeyManager().getValue(key: "TWITTER_API_KEY") as? String else {
            return
        }
        guard let API_SECRET_KEY = KeyManager().getValue(key: "TWITTER_API_SECRET_KEY") as? String else {
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

extension AppDelegate: FUIAuthDelegate {
    var authUI: FUIAuth { get { return FUIAuth.defaultAuthUI()!}}
    
    private func configureFirebaseUI() {
        self.authUI.delegate = self
        self.authUI.providers = providers
        
        
        handler.addStateDidChangeListener{ (auth, user) in
            self.notification.post(name: .DidFirebaseLoginstateChanged, object: nil)
        }
    }
    
    @objc func didFirebaseLoginNotification(_ notification: Notification) {
        
    }
    
    @objc func didFirebaseLogoutNotification(_ notification: Notification) {
        
    }
    
    func authPickerViewController(forAuthUI authUI: FUIAuth) -> FUIAuthPickerViewController {
        return FUIAuthPickerViewController(nibName: "LoginViewController",
                                                 bundle: Bundle.main,
                                                 authUI: authUI)
    }
    
    //　認証画面から離れたときに呼ばれる
    public func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?){
        // 認証に成功した場合
        if error == nil {
            // ...
        }
        // 認証に失敗した場合
    }
    
}

