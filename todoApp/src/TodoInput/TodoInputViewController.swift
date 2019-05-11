//
//  TodoInputViewController.swift
//  todoApp
//
//  Created by RIVER on 2019/05/10.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import UIKit

/*-----------------------------

 # 責務について
 
 ## プロパティ
 - closeBarButton
 - bottomButtonView
 
 - todoInputFormViewController
    - これはselfが参照された時点で生成されそう



 -----------------------------*/

final class TodoInputViewController: UIViewController {
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var bottomButtonView: BottomButtonView!
    @IBOutlet weak var container: UIView!
    
    private var presenter: TodoInputPresenterInput!
    
    func inject(presenter: TodoInputPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    deinit {
        print("deinit input")
    }
    
    private func setupViews() {
        cancelBarButton.action = #selector(tapCloseButton(_:))
        bottomButtonView.button.setTitle("完了する", for: .normal)
        bottomButtonView.button.addTarget(self, action: #selector(tapBottomButton(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc func tapCloseButton(_ sender: UIButton) {
        self.transitionToNextViewController()
    }
    
    @objc func tapBottomButton(_ sender: UIButton) {
        presenter.willPerformPrevious()
    }

}

extension TodoInputViewController: TodoInputPresenterOutput {
    func transitionToNextViewController() {
        self.dismiss(animated: true)
    }
}
