//
//  TodoInputPresenter.swift
//  todoApp
//
//  Created by RIVER on 2019/04/27.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import Foundation

protocol TodoInputPresenterInput {
    func registerTask()
    func willTransitionToNextViewController()
}

protocol TodoInputPresenterOutput: AnyObject {
    func transitionToNextViewController()
}

final class TodoInputPresenter: TodoInputPresenterInput {
    private var dateSelected: String!
    
    private weak var view: TodoInputPresenterOutput!
    private var model: TodoInputModelInput
    
    init(dateSelected: String, view: TodoInputPresenterOutput, model: TodoInputModelInput) {
        self.dateSelected = dateSelected
        self.view = view
        self.model = model
    }
    
    func registerTask() {
        
    }
    
    func willTransitionToNextViewController() {
        // データソースと連携

        // 画面遷移
        view.transitionToNextViewController()
    }
}
