//
//  CalendarViewController.swift
//  todoApp
//
//  Created by RIVER on 2019/04/27.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import UIKit
import FSCalendar
import Firebase

final class CalendarViewController: UIViewController {
    @IBOutlet private weak var calendar: FSCalendar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var bottomButtonView: BottomButtonView!
    
    // Firebasen認証のインスタンス
    let firebaseAuth = Auth.auth()
    // NotificationCenter
    let notification = NotificationCenter.default
    
    deinit {
        notification.removeObserver(self)
    }
    
    func initObservers() {
        notification.addObserver(self,
                                 selector: #selector(didFirebaseLoginstateChangedNotification(_:)),
                                 name: .DidFirebaseLoginstateChanged, object: nil)
    }
    
    @objc func didFirebaseLoginstateChangedNotification(_ notification: Notification) {
        if let state = firebaseAuth.currentUser {
            // ユーザ情報を更新
            setupViews()
        } else {
            // ユーザ情報を更新
            setupViews()
        }
    }
    
    private var presenter: CalendarPresenterInput!
    
    func inject(presenter: CalendarPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        bottomButtonView.button.setTitle("タスクを追加", for: .normal)
        bottomButtonView.button.addTarget(self, action: #selector(tapBottomButton(_:)), for: UIControl.Event.touchUpInside)
        
        // カレンダーのセットアップ
        // 初期値を当日のものとして保持
        let today: Date = NSDate() as Date
        calendar.select(today, scrollToDate: true)
        presenter.didSelectDate(didSelect: calendar.selectedDate!)
    }
    
    @objc func tapBottomButton(_ sender: UIButton) {
        presenter.willTransitionToNextViewController()
    }

}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    // カレンダーがタッチされた時の処理
    // カレンダービューの選択状況を更新((presenter.dateSelectedを反映
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        calendar.deselect(date)
        calendar.select(date, scrollToDate: true)
        presenter.didSelectDate(didSelect: date)
    }
    
}

extension CalendarViewController: CalendarPresenterOutput {
    func transitionToNextViewController(selectedDate: String) {
        let view = UIStoryboard(
            name: "TodoInput",
            bundle: nil)
            .instantiateViewController(
                withIdentifier: "initial") as! TodoInputViewController
        let model = TodoInputModel()
        let presenter = TodoInputPresenter(dateSelected: self.presenter.dateSelected,
                                           view: view,
                                           model: model)
        view.inject(presenter: presenter)

        present(view, animated: true, completion: nil)
    }
}


