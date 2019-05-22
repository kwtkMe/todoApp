//
//  TodoInputFormViewController.swift
//  todoApp
//
//  Created by RIVER on 2019/05/06.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import UIKit
import Eureka

class TodoInputFormViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFormView()
    }
    
    private func setupFormView() {
        form
            +++ Section("タスク名")
            <<< NameRow("taskName") {
                $0.title = "タスク名"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnBlur
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            
            +++ Section("時間設定")
            <<< SwitchRow("taskTimeSwitch") {
                $0.title = "時間を設定"
            }
            <<< TimeRow("taskTime") {
                $0.hidden = Condition.function(["taskTimeSwitch"]) { form in
                    return !((form.rowBy(tag: "taskTimeSwitch") as? SwitchRow)?.value ?? false)
                }
                $0.value = Calendar(identifier: .gregorian).date(byAdding: .year, value: -20, to: Date())
            }

    }

}
