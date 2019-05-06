//
//  TodoInputModel.swift
//  todoApp
//
//  Created by RIVER on 2019/04/27.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import Foundation

protocol TodoInputModelInput {
    
}

final class TodoInputModel: TodoInputModelInput {
    private var selectedDate: String
    
    init(selectedDate: String) {
        self.selectedDate = selectedDate
    }
}
