//
//  TodoInputPresenter.swift
//  todoApp
//
//  Created by RIVER on 2019/04/27.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import Foundation

protocol TodoInputPresenterInput {
    func willPerformPrevious()
}

protocol TodoInputPresenterOutput: AnyObject {
    func transitionToNextViewController(selectedDate: String)
}

final class TodoInputPresenter: TodoInputPresenterInput {
    private var selectedDate: String
    
    private weak var view: TodoInputPresenterOutput!
    private var model: TodoInputModelInput
    
    init(selectedDate: String, view: TodoInputPresenterOutput, model: TodoInputModelInput) {
        self.selectedDate = selectedDate
        self.view = view
        self.model = model
    }
    
    func willPerformPrevious() {
        // データソースと連携
        
        // 画面遷移
        view.transitionToNextViewController(selectedDate: selectedDate)
    }
}
