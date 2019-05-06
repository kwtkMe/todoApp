//
//  ListPresenter.swift
//  todoApp
//
//  Created by RIVER on 2019/04/27.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import Foundation

protocol ListPresenterInput {
    func didTapBottomButton()
}

protocol ListPresenterOutput: AnyObject {
    func transitionToNextViewController(selectedDate: String)
}

final class ListPresenter: ListPresenterInput {    
    private(set) var selectedDate: String = "date"
    
    private weak var view: ListPresenterOutput!
    private var model: ListModelInput
    
    init(view: ListPresenterOutput, model: ListModelInput) {
        self.view = view
        self.model = model
    }
    
    // 画面下部のボタンをタップ
    // 画面遷移
    func didTapBottomButton() {
        // 日時の確認をしたい(希望)
        
        // 画面遷移
        view.transitionToNextViewController(selectedDate: selectedDate)
    }
}
