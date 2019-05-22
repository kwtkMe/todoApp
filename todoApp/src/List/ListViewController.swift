//
//  ListViewController.swift
//  todoApp
//
//  Created by RIVER on 2019/04/27.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import UIKit
import Firebase

final class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // Firebaseのインスタンス
    let firebase = Firebase.sharedInstance
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
        if let state = firebase.authUI.auth?.currentUser {
            // ユーザ情報を更新
            setupViews()
        } else {
            // ユーザ情報を更新
            setupViews()
        }
    }
    
    private var presenter: ListPresenterInput!
    
    func inject(presenter: ListPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    // セルを設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 状況次第でセルのプロパティを変更して返す
        // 状況が知りたい
        let cell = setTableViewCellProperty(indexPath: indexPath)
        
        return cell
    }

    private func setTableViewCellProperty(indexPath: IndexPath) -> UITableViewCell {
        // ベースになるセルを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskTableViewCell
        // セルのプロパティを設定
        cell.taskNameLabel.text = presenter.dataOfTask[indexPath.row].name
        cell.taskTimeLabel.text = presenter.dataOfTask[indexPath.row].time ?? "時間設定なし"
        
        return cell
    }
    
    // セルの個数を設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfTask
    }
    
    // セクションの名前を設定
    func tableView(tableView:UITableView, titleForHeaderInSection section:Int) -> String?{

        return "yeah_REIWAMARU"
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
    //スワイプしたセルを削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
        }
    }
    
    
}

extension ListViewController: ListPresenterOutput {
    /* 以下を更新する
     - タスクビュー
    */
    func updateViews() {
        // タスクビュー
        tableView.reloadData()
    }
    
    
}
