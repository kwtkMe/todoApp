//
//  FirebaseUI.swift
//  todoApp
//
//  Created by RIVER on 2019/05/21.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import TwitterKit


class FirebaseUI: NSObject {
    
    static let sharedInstance = FirebaseUI()
    
    // 認証に使用するプロバイダの選択
    let providers: [FUIAuthProvider] = [
        FUITwitterAuth(),
        FUIGoogleAuth()
    ]

    //Firebase認証についてのUI
     var authUI: FUIAuth { get { return FUIAuth.defaultAuthUI()!}}

    // Firebase認証のログイン状態についてのハンドラ
    var handler = Auth.auth()
    // NotificationCenter
    let notification = NotificationCenter.default

    deinit {
        notification.removeObserver(self)
        Auth.auth().removeStateDidChangeListener(handler)
    }

    private override init() {
        super.init()

        authUI.delegate = self
        authUI.providers = providers

        handler.addStateDidChangeListener{ (auth, user) in
            self.notification.post(name: .DidFirebaseLoginstateChanged, object: nil)
        }
    }


}

extension FirebaseUI: FUIAuthDelegate {
    private func configureFirebaseUI() {
        self.authUI.delegate = self
        self.authUI.providers = providers

        handler.addStateDidChangeListener{ (auth, user) in
            self.notification.post(name: .DidFirebaseLoginstateChanged, object: nil)
        }
    }

    //    func authPickerViewController(forAuthUI authUI: FUIAuth) -> FUIAuthPickerViewController {
    //        return FUIAuthPickerViewController(nibName: "LoginViewController",
    //                                                 bundle: Bundle.main,
    //                                                 authUI: authUI)
    //    }

    //　認証画面から離れたときに呼ばれる
    public func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?){
        // 認証に成功した場合
        if error == nil {
            // ...
        }
        // 認証に失敗した場合
    }

}