//
//  ListPresenter.swift
//  todoApp
//
//  Created by RIVER on 2019/04/27.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import Foundation

protocol ListPresenterInput {

}

protocol ListPresenterOutput: AnyObject {

}

final class ListPresenter: ListPresenterInput {        
    private weak var view: ListPresenterOutput!
    private var model: ListModelInput
    
    init(view: ListPresenterOutput, model: ListModelInput) {
        self.view = view
        self.model = model
    }
}
