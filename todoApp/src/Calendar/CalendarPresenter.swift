//
//  CalendarPresenter.swift
//  todoApp
//
//  Created by RIVER on 2019/04/27.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import Foundation
import UIKit
import FSCalendar

/* ここの責務は
 - タスクの遂行状況の変更(チェックボタンを押す)
 - タスクの編集
 - タスクの削除
*/

protocol CalendarPresenterInput {
    var dateSelected: String { get }
    var numberOfTask: Int { get }
    var dataOfTask: [TaskDataStruct] { get }
    func didSelectDate(didSelect date: Date)
    func didTapRadioButton(at row: Int)
    func didEditTask(at row: Int)
    func didDeleteTask(at row: Int)
    func willTransitionToNextViewController()
}

protocol CalendarPresenterOutput: AnyObject {
    func updateViews()
    func transitionToNextViewController(selectedDate: String)
}

enum cellDeleteMode {
    case plane
    case delete
}

final class CalendarPresenter: CalendarPresenterInput {    
    private(set) var selectedDate: Date = NSDate() as Date
    private(set) var tasks: [TaskDataStruct] = [] // FireStoreのデータ
    
    private weak var view: CalendarPresenterOutput!
    private var model: CalendarModelInput
    
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
        if let state = firebase.authUI.auth?.currentUser {
            let user: String! = state.uid
            let collection = firebase.db.collection("users").document(user)
                .collection("task").whereField("date", isEqualTo: dateSelected)
            collection.getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.tasks.removeAll()
                    for document in querySnapshot!.documents {
                        self.tasks.append(TaskDataStruct(dictionary: document.data()))
                    }
                    DispatchQueue.main.async {
                        // ユーザ情報を更新
                        self.view.updateViews()
                    }
                }
            }
        } else {
            // ユーザ情報を更新
            view.updateViews()
        }
    }
    
    deinit {
        notification.removeObserver(self)
    }
    
    init(view: CalendarPresenterOutput, model: CalendarModelInput) {
        self.view = view
        self.model = model
        
        initObservers()
        self.notification.post(name: .DidFirestoreUpdated, object: nil)
    }
        
    var numberOfTask: Int {
        switch self.cellDeleteState {
        case .plane:
            return tasks.count
        case .delete:
            return tasks.count - 1
        }
    }
    
    var dataOfTask: [TaskDataStruct] {
        return tasks
    }
    
    var dateSelected: String {
        cellDeleteState = .plane
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "jp_JP") as Locale
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: selectedDate)
    }
    
    // 保持する日付を切り替える
    func didSelectDate(didSelect date: Date) {
        selectedDate = date
        self.notification.post(name: .DidFirestoreUpdated, object: nil)
    }
    
    // チェックボタンを押した
    func didTapRadioButton(at row: Int) {
        // データソースにアクセス
        
        // データの更新を通知
        self.notification.post(name: .DidFirestoreUpdated, object: nil)
    }
    
    
    // タスクを編集した
    func didEditTask(at row: Int) {
        
        
        // データの更新を通知
        self.notification.post(name: .DidFirestoreUpdated, object: nil)
    }
    
    // タスクを削除した
    func didDeleteTask(at row: Int) {
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
    
    // 画面遷移
    func willTransitionToNextViewController() {
        view.transitionToNextViewController(selectedDate: dateSelected)
    }
    
}
