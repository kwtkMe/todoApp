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
    func didSelectDate(at date: Date)
    func didTapRadioButton()
    func didDeleteTask()
    func didTapBottomButton()
}

protocol CalendarPresenterOutput: AnyObject {
    func transitionToNextViewController(selectedDate: String)
}

final class CalendarPresenter: CalendarPresenterInput {
    private(set) var selectedDate: String = "date"
    
    private weak var view: CalendarPresenterOutput!
    private var model: CalendarModelInput
    
    init(view: CalendarPresenterOutput, model: CalendarModelInput) {
        self.view = view
        self.model = model
    }
    
    // 保持する日付を切り替える
    // カレンダービューの選択状況を更新
    // タスクビューを更新
    func didSelectDate(at date: Date) {
        
    }
    
    // タスクのラジオボタンを更新
    func didTapRadioButton() {
        // データソースにアクセス
    }
    
    // タスクを削除
    func didDeleteTask() {
        // データソースにアクセス
    }
    
    // 画面下部のボタンをタップ
    // 画面遷移
    func didTapBottomButton() {
        // 日時の確認をしたい(希望)
        
        // 画面遷移
        view.transitionToNextViewController(selectedDate: selectedDate)
    }
    
}
