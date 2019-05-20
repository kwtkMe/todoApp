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
    
    // facebook&Google&電話番号認証時に呼ばれる関数
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        // GoogleもしくはFacebook認証の場合、trueを返す
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // 電話番号認証の場合、trueを返す
        if Auth.auth().canHandle(url) {
            return true
        }
        return false
    }
    
    // 電話番号認証の場合に通知をHandel出来るかチェックする関数
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification notification: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if Auth.auth().canHandleNotification(notification) {
            completionHandler(.noData)
            return
        }
        // エラーの時の処理を書く
    }
}

extension AppDelegate: FUIAuthDelegate {
    var authUI: FUIAuth { get { return FUIAuth.defaultAuthUI()!}}
    
    private func configureFirebaseUI() {
        self.authUI.delegate = self
        self.authUI.providers = providers
    }
    
    //　認証画面から離れたときに呼ばれる（キャンセルボタン押下含む）
    public func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?){
        // 認証に成功した場合
        if error == nil {
            // ログイン用のモーダル(LoginViewController)を退避させる
            // ユーザ情報を更新
        }
        // 認証に失敗した場合
    }
}

