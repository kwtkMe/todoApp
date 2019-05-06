//
//  ListViewController.swift
//  todoApp
//
//  Created by RIVER on 2019/04/27.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var bottomButtonView: BottomButtonView!
    
    private var presenter: ListPresenterInput!
    func inject(presenter: ListPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews() {
        bottomButtonView.button.setTitle("タスクを追加", for: .normal)
        bottomButtonView.button.addTarget(self, action: #selector(tapButton(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc func tapButton(_ sender: UIButton) {
        presenter.didTapBottomButton()
    }

}

extension ListViewController: ListPresenterOutput {
//    func transitionToNextViewController(selectedDate: String) {
//        let todoInputVC = UIStoryboard(
//            name: "TodoInput",
//            bundle: nil)
//            .instantiateInitialViewController() as! TodoInputViewController
//        let model = TodoInputModel(selectedDate: selectedDate)
//        let presenter = TodoInputPresenter(
//            selectedDate: selectedDate,
//            view: todoInputVC,
//            model: model)
//        todoInputVC.inject(presenter: presenter)
//
//        self.present(todoInputVC, animated: true, completion: nil)
//    }
    
    func transitionToNextViewController(selectedDate: String) {
        let todoInputFVC = UIStoryboard(
            name: "TaskView",
            bundle: nil)
            .instantiateViewController(
                withIdentifier: "input") as! TodoInputFormViewController
        let model = TodoInputModel(selectedDate: selectedDate)
        let presenter = TodoInputPresenter(
            selectedDate: selectedDate,
            view: todoInputFVC,
            model: model)
        todoInputFVC.inject(presenter: presenter)
        
        self.navigationController?.pushViewController(todoInputFVC, animated: true)
    }
    
}
