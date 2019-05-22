//
//  TodoInputPresenter.swift
//  todoApp
//
//  Created by RIVER on 2019/04/27.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import Foundation
import FirebaseFirestore

// ここでは書き込みの責務のみ扱う
protocol TodoInputPresenterInput {
    func registerTask(taskName: String, taskTime: String?)
    func willTransitionToNextViewController()
}

protocol TodoInputPresenterOutput: AnyObject {
    func transitionToNextViewController()
}

final class TodoInputPresenter: TodoInputPresenterInput {
    private var dateSelected: String!
    
    private weak var view: TodoInputPresenterOutput!
    private var model: TodoInputModelInput
    
    // Firebaseのインスタンス
    let firebase = Firebase.sharedInstance
    
    // NotificationCenter
    let notification = NotificationCenter.default
    
    deinit {
        notification.removeObserver(self)
    }
    
    init(dateSelected: String, view: TodoInputPresenterOutput, model: TodoInputModelInput) {
        self.dateSelected = dateSelected
        self.view = view
        self.model = model
    }
    
    func registerTask(taskName: String, taskTime: String?) {
        if let state = firebase.authUI.auth?.currentUser {
            let user: String! = state.uid
            let data: [String: Any] = [
                "name": taskName,
                "time": taskTime ?? "",
                "completion" : false
            ]
            
            firebase.db.collection("users").document(user)
            .collection("task").addDocument(data: data){ err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added!")
                    self.notification.post(name: .DidFirestoreUpdated, object: nil)
                }
            }
        } else {
            // ...
        }
    }
    
    func willTransitionToNextViewController() {       
        // 画面遷移
        view.transitionToNextViewController()
    }
}
