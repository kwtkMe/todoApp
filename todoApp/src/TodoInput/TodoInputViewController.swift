//
//  TodoInputViewController.swift
//  todoApp
//
//  Created by RIVER on 2019/04/27.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import UIKit

final class TodoInputViewController: UIViewController {

    @IBOutlet weak var bottomButtonView: BottomButtonView!
    
    private var presenter: TodoInputPresenterInput!
    func inject(presenter: TodoInputPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews() {
        bottomButtonView.button.setTitle("完了する", for: .normal)
        bottomButtonView.button.addTarget(self, action: #selector(tapButton(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc func tapButton(_ sender: UIButton) {
        presenter.didTapBottomButton()
    }
    
    @IBAction func tapCloseButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension TodoInputViewController: TodoInputPresenterOutput {
    func transitionToNextViewController(selectedDate: String) {
        self.dismiss(animated: true, completion: nil)
    }
}
