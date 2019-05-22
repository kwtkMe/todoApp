//
//  TaskViewController.swift
//  todoApp
//
//  Created by RIVER on 2019/05/06.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class TaskViewController: UIViewController {
    @IBOutlet weak var userButton: UIBarButtonItem!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
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
            let userImage: UIImage = state.photoURL?.toUIImage() ?? UIImage(named: "user")!
            userButton.image = userImage.withRenderingMode(.alwaysOriginal)
            setupViews()
        } else {
            userButton.image = UIImage(named: "user")!.withRenderingMode(.alwaysOriginal)
            setupViews()
            // ログイン画面の表示
            let authUI = FUIAuth.defaultAuthUI()!
            let authViewController = authUI.authViewController()
            present(authViewController, animated: true, completion: nil)
            
        }
    }
    
    private lazy var calendarViewController: CalendarViewController = {
        let view = UIStoryboard(
            name: "Calendar",
            bundle: Bundle.main)
            .instantiateInitialViewController() as! CalendarViewController
        let model = CalendarModel()
        let presenter = CalendarPresenter(view: view, model: model)
        view.inject(presenter: presenter)
        
        add(asChildViewController: view)
        return view
    }()
    private lazy var listViewController: ListViewController = {
        let view = UIStoryboard(
            name: "List",
            bundle: Bundle.main)
            .instantiateInitialViewController() as! ListViewController
        let model = ListModel()
        let presenter = ListPresenter(view: view, model: model)
        view.inject(presenter: presenter)
        
        add(asChildViewController: view)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initObservers()
        self.notification.post(name: .DidFirebaseLoginstateChanged, object: nil)
    }
    
    private func setupViews() {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: listViewController)
            add(asChildViewController: calendarViewController)
        } else {
            remove(asChildViewController: calendarViewController)
            add(asChildViewController: listViewController)
        }
    }
    
    @IBAction func tapUserButton(_ sender: UIBarButtonItem) {
        if let state = firebase.authUI.auth?.currentUser {
            let alert = UIAlertController(title: "ログアウト", message: "ログアウトしますか？", preferredStyle: UIAlertController.Style.alert)
            let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel,
                                             handler:{ (action: UIAlertAction!) in })
            let defaultAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default,
                                              handler:{(action: UIAlertAction!) in
                                                do {
                                                    try self.firebase.authUI.auth?.signOut()
                                                } catch let signOutError as NSError {
                                                    print ("Error signing out: %@", signOutError)
                                                }
            })
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        } else {
            let authUI = FUIAuth.defaultAuthUI()!
            let authViewController = authUI.authViewController()
            present(authViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func tapSegmentedControl(_ sender: UISegmentedControl) {
        setupViews()
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }

}
