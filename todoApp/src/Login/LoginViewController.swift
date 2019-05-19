//
//  LoginViewController.swift
//  todoApp
//
//  Created by RIVER on 2019/05/19.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import UIKit
import FirebaseAuth
import TwitterKit

class LoginViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if let session = session {
                let authToken = session.authToken
                let authTokenSecret = session.authTokenSecret
                let credential = TwitterAuthProvider.credential(withToken: session.authToken, secret: session.authTokenSecret)
                
                Auth.auth().signIn(with: credential) { (authResult, error) in
                    if let error = error { return }
                    //Sign In Completed
                }
            }
        })
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }
}
