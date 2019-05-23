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

enum cellDeleteMode {
    case plane
    case delete
}

protocol ListPresenterInput {
    var numberOfTask: Int { get }
    var dataOfTask: [TaskDataStruct] { get }
    var numberOfSection: Int { get }
    var dataOfSection: [[TaskDataStruct]] { get }
    func didTapRadioButton(at row: Int)
    func didEditTask(at row: Int)
    func didDeleteTask(at row: Int)
}

protocol ListPresenterOutput: AnyObject {
    func updateViews()
}

final class ListPresenter: ListPresenterInput {
    private(set) var tasks: [TaskDataStruct] = [] // FireStoreのデータ
    
    private weak var view: ListPresenterOutput!
    private var model: ListModelInput
    
    // Firebaseのインスタンス
    let firebase = Firebase.sharedInstance
    // NotificationCenter
    let notification = NotificationCenter.default
    
    // セルの消去を感知する
    var cellDeleteState = cellDeleteMode.plane
    
    func initObservers() {
        notification.addObserver(self,
                                 selector: #selector(didFirestoreUpdatedNotification(_:)),
                                 name: .DidFirestoreUpdated, object: nil)
    }
    
    @objc func didFirestoreUpdatedNotification(_ notification: Notification) {
        /*
         データを取ってくる
         viewに値を受け渡す
        */
        if let state = firebase.authUI.auth?.currentUser {
            let user: String! = state.uid
            let collection = firebase.db.collection("users").document(user)
                .collection("task")
            collection.getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.tasks.removeAll()
                    for document in querySnapshot!.documents {
                        self.tasks.append(TaskDataStruct(dictionary: document.data()))
                    }
                }
            }
            DispatchQueue.main.async {
                // ユーザ情報を更新
                self.view.updateViews()
            }
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
        
        initObservers()
        self.notification.post(name: .DidFirestoreUpdated, object: nil)
    }
    
    var numberOfTask: Int {
        return tasks.count
    }
    
    var dataOfTask: [TaskDataStruct] {
        return tasks
    }
    
    var numberOfSection: Int {
        return tasks.count
    }
    
    var dataOfSection: [[TaskDataStruct]] {
        return [tasks]
    }
    
    // チェックボタンを押した
    func didTapRadioButton(at row: Int) {
        // データソースにアクセス
        
        // データの更新を通知
        self.notification.post(name: .DidFirestoreUpdated, object: nil)
    }
    
    // タスクを編集した
    func didEditTask(at row: Int) {
        // データソースにアクセス
        
        // データの更新を通知
        self.notification.post(name: .DidFirestoreUpdated, object: nil)
    }
    
    // タスクを削除した
    func didDeleteTask(at row: Int) {
        // データソースにアクセス
        cellDeleteState = .delete
        // データソースにアクセス
        if let state = firebase.authUI.auth?.currentUser {
            let user: String! = state.uid
            let id = dataOfTask[row].id
            let collection = firebase.db.collection("users").document(user)
                .collection("task")
            collection.document(id).delete() { err in
                if let err = err{
                    print("Error removing document: \(err)")
                }else{
                    print("Document successfully removed!")
                }
            }
        }
        // データの更新を通知
        self.notification.post(name: .DidFirestoreUpdated, object: nil)
    }
    
}
