//
//  TodoInputViewController.swift
//  todoApp
//
//  Created by RIVER on 2019/05/10.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import UIKit
import Eureka

final class TodoInputViewController: UIViewController {
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var bottomButtonView: BottomButtonView!
    @IBOutlet weak var container: UIView!
    private lazy var formViewController: TodoInputFormViewController = {
        let viewController = TodoInputFormViewController()
        addChild(viewController)
        container.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
        return viewController
    }()
    private var taskNameRow: NameRow!
    private var taskTimeRow: TimeRow!
    
    private var presenter: TodoInputPresenterInput!
    
    func inject(presenter: TodoInputPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        cancelBarButton.action = #selector(tapCloseButton(_:))
        bottomButtonView.button.setTitle("完了する", for: .normal)
        bottomButtonView.button.addTarget(self, action: #selector(tapBottomButton(_:)), for: UIControl.Event.touchUpInside)

        // formViewControllerの設定
        taskNameRow = formViewController.form.rowBy(tag: "taskName")
        taskTimeRow = formViewController.form.rowBy(tag: "taskTime")
    }
    
    @objc func tapCloseButton(_ sender: UIButton) {
        self.transitionToNextViewController()
    }
    
    @objc func tapBottomButton(_ sender: UIButton) {
        let errors = formViewController.form.validate()
        guard errors.isEmpty else {
            print("validate errors:", errors)
            return
        }
        
        let taskName = taskNameRow.value!
        // 時間指定についてはOptional
        let taskTimeOption = taskTimeRow.value
        var taskTime: String?
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "jp_JP") as Locale
        dateFormatter.dateFormat = "HH:mm"
        if let time = taskTimeOption {
            taskTime = dateFormatter.string(from: time)
        } else {
            taskTime = nil
        }
        presenter.registerTask(taskName: taskName, taskTime: taskTime)
        presenter.willTransitionToNextViewController()
    }

}

extension TodoInputViewController: TodoInputPresenterOutput {
    func transitionToNextViewController() {
        self.dismiss(animated: true)
    }
}
