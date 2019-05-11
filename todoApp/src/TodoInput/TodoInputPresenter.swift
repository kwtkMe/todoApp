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
    func transitionToNextViewController()
}

final class TodoInputPresenter: TodoInputPresenterInput {
    private weak var view: TodoInputPresenterOutput!
    private var model: TodoInputModelInput
    
    init(view: TodoInputPresenterOutput, model: TodoInputModelInput) {
        self.view = view
        self.model = model
        
        print("model oh_yeah")
    }
    
    func willPerformPrevious() {
        // データソースと連携

        // 画面遷移
        view.transitionToNextViewController()
    }
}
