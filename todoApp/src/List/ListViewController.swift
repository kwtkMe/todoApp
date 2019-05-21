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

extension ListViewController: ListPresenterOutput {
    
}
