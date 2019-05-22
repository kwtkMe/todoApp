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
import FirebaseUI

final class CalendarViewController: UIViewController {
    @IBOutlet private weak var calendar: FSCalendar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var bottomButtonView: BottomButtonView!
    
    // Firebaseのインスタンス
    let firebase = Firebase.sharedInstance
    // NotificationCenter
    let notification = NotificationCenter.default
    
    deinit {
        notification.removeObserver(self)
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
        if let state = firebase.authUI.auth?.currentUser {
            presenter.willTransitionToNextViewController()
        } else {
            let alert = UIAlertController(title: "ユーザ情報なし", message: "ログインしてください", preferredStyle: UIAlertController.Style.alert)
            let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel,
                                             handler:{ (action: UIAlertAction!) in })
            let defaultAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default,
                                              handler:{(action: UIAlertAction!) in
                                                do {
                                                    self.notification.post(name: .DidFirebaseLoginstateChanged, object: nil)
                                                } catch let signOutError as NSError {
                                                    print ("Error signing out: %@", signOutError)
                                                }
            })
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        }
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

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    // セルを設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let testCell: UITableViewCell = UITableViewCell()
        return testCell
    }
        
    // セルの個数を設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
        
    // セクションの名前を設定
    func tableView(tableView:UITableView, titleForHeaderInSection section:Int) -> String?{
        
        return ""
    }
    
    // セクションの個数を設定
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    // セルを押下したとき
    func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        // 一覧のCell選択時イベント内容を実装
    }
    
    // セルをスワイプで削除
    // セルの編集許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    //スワイプしたセルを削除　※arrayNameは変数名に変更してください
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
        }
    }
    
}

extension CalendarViewController: CalendarPresenterOutput {
    /* 以下を更新する
     - カレンダービュー
     - タスクビュー
     */
    func updateViews() {
        // カレンダービュー
        // タスクビュー
    }
    
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


