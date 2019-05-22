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
    func didSelectDate(didSelect date: Date)
    func didTapRadioButton()
    func didEditTask()
    func didDeleteTask()
    func willTransitionToNextViewController()
}

protocol CalendarPresenterOutput: AnyObject {
    func updateViews()
    func transitionToNextViewController(selectedDate: String)
}

final class CalendarPresenter: CalendarPresenterInput {
    private(set) var selectedDate: Date!
    
    private weak var view: CalendarPresenterOutput!
    private var model: CalendarModelInput
    
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
    
    init(view: CalendarPresenterOutput, model: CalendarModelInput) {
        self.view = view
        self.model = model
    }
    
    // カレンダー上の日付を押した
    var dateSelected: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "jp_JP") as Locale
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: selectedDate)
    }
    
    // 保持する日付を切り替える
    func didSelectDate(didSelect date: Date) {
        selectedDate = date
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
    
    // 画面遷移
    func willTransitionToNextViewController() {
        view.transitionToNextViewController(selectedDate: dateSelected)
    }
    
}
