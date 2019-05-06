//
//  CalendarViewController.swift
//  todoApp
//
//  Created by RIVER on 2019/04/27.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import UIKit
import FSCalendar

final class CalendarViewController: UIViewController {
    @IBOutlet private weak var calendar: FSCalendar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var bottomButtonView: BottomButtonView!
    
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
        bottomButtonView.button.addTarget(self, action: #selector(tapButton(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc func tapButton(_ sender: UIButton) {
        presenter.didTapBottomButton()
    }

}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
//    // カレンダーがタッチされた時の処理
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        calendar.deselect(date)
//        presenter.didSelectDate(at: date)
//    }
    
}

extension CalendarViewController: CalendarPresenterOutput {
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


