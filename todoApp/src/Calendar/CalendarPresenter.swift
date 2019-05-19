//
//  CalendarPresenter.swift
//  todoApp
//
//  Created by RIVER on 2019/04/27.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import Foundation
import UIKit
import FSCalendar

protocol CalendarPresenterInput {
    var dateSelected: String { get }
    func didSelectDate(didSelect date: Date)
    func didTapRadioButton()
    func didDeleteTask()
    func willTransitionToNextViewController()
}

protocol CalendarPresenterOutput: AnyObject {
    func transitionToNextViewController(selectedDate: String)
}

final class CalendarPresenter: CalendarPresenterInput {
    private(set) var selectedDate: Date!
    
    private weak var view: CalendarPresenterOutput!
    private var model: CalendarModelInput
    
    init(view: CalendarPresenterOutput, model: CalendarModelInput) {
        self.view = view
        self.model = model
    }
    
    var dateSelected: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "jp_JP") as Locale
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: selectedDate)
    }
    
    // 保持する日付を切り替える
    func didSelectDate(didSelect date: Date) {
        selectedDate = date
    }
    
    // タスクのラジオボタンを更新
    func didTapRadioButton() {
        // データソースにアクセス
    }
    
    // タスクを削除
    func didDeleteTask() {
        // データソースにアクセス
    }
    
    // 画面遷移
    func willTransitionToNextViewController() {
        view.transitionToNextViewController(selectedDate: dateSelected)
    }
    
}
