//
//  BottomButtonViewPresenter.swift
//  todoApp
//
//  Created by RIVER on 2019/05/06.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import Foundation
import UIKit

protocol BottomButtonViewPresenterOutput: AnyObject {
    func transitionToUserDetail(userName: String)
}

final class BottomButtonViewPresenter {
    
    private weak var view: BottomButtonViewPresenterOutput!
    
    init(view: BottomButtonViewPresenterOutput) {
        self.view = view
    }
    
}
