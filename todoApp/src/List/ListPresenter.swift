//
//  ListPresenter.swift
//  todoApp
//
//  Created by RIVER on 2019/04/27.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import Foundation

/* ここの責務は
 - タスクの遂行状況の変更(チェックボタンを押す)
 - タスクの編集
 - タスクの削除
 */
protocol ListPresenterInput {
    func didTapRadioButton()
    func didEditTask()
    func didDeleteTask()
}

protocol ListPresenterOutput: AnyObject {
    func updateViews()
}

final class ListPresenter: ListPresenterInput {
    private weak var view: ListPresenterOutput!
    private var model: ListModelInput
    
    // Firebaseのインスタンス
    let firebase = Firebase.sharedInstance
    // NotificationCenter
    let notification = NotificationCenter.default
    
    func initObservers() {
        notification.addObserver(self,
                                 selector: #selector(didFirestoreUpdatedNotification(_:)),
                                 name: .DidFirestoreUpdated, object: nil)
    }
    
    @objc func didFirestoreUpdatedNotification(_ notification: Notification) {
        if let state = firebase.authUI.auth?.currentUser {
            // ユーザ情報を更新
            view.updateViews()
        } else {
            // ユーザ情報を更新
            view.updateViews()
        }
    }
    
    deinit {
        notification.removeObserver(self)
    }
    
    init(view: ListPresenterOutput, model: ListModelInput) {
        self.view = view
        self.model = model
    }
    
    // チェックボタンを押した
    func didTapRadioButton() {
        // データソースにアクセス
        
        // データの更新を通知
        self.notification.post(name: .DidFirestoreUpdated, object: nil)
    }
    
    // タスクを編集した
    func didEditTask() {
        // データソースにアクセス
        
        // データの更新を通知
        self.notification.post(name: .DidFirestoreUpdated, object: nil)
    }
    
    // タスクを削除した
    func didDeleteTask() {
        // データソースにアクセス
        
        // データの更新を通知
        self.notification.post(name: .DidFirestoreUpdated, object: nil)
    }
    
}
