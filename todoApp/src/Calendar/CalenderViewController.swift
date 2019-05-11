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
        bottomButtonView.button.addTarget(self, action: #selector(tapBottomButton(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc func tapBottomButton(_ sender: UIButton) {
        presenter.willPerformPrevious()
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
    func transitionToNextViewController(selectedDate: String) {
        let view = UIStoryboard(
            name: "TodoInput",
            bundle: nil)
            .instantiateViewController(
                withIdentifier: "initial") as! TodoInputViewController
        let model = TodoInputModel()
        let presenter = TodoInputPresenter(view: view, model: model)
        view.inject(presenter: presenter)

        present(view, animated: true, completion: nil)
    }
}


