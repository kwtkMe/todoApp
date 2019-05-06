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
    
    @IBOutlet weak var bottomButtonView: BottomButtonView!
    
    private var presenter: TodoInputPresenterInput!
    func inject(presenter: TodoInputPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupEurekaFormView()
        setupViews()
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.isHidden = false
        title = "タスクを入力"
        let backButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                         target: self,
                                         action: #selector(backPressed))
        navigationItem.leftBarButtonItem = backButton
        
        let button = UIBarButtonItem(barButtonSystemItem: .save,
                                     target: self,
                                     action: #selector(didTapSaveButton(sender:)))
        
        navigationItem.rightBarButtonItem = button
        navigationItem.title = title
    }
    
    private func setupEurekaFormView() {
        form
            +++ Section()
            <<< NameRow("NameRowTag") {
                $0.title = "Name"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnBlur
                }.onChange {
                    print("Name changed:", $0.value ?? "");
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< DateRow("BirthdayRowTag") {
                $0.title = "Birthday"
                $0.value = Calendar(identifier: .gregorian).date(byAdding: .year, value: -20, to: Date())
            }
            
            +++ Section("Account")
            <<< EmailRow("EmailRowTag") {
                $0.title = "Email"
                $0.add(rule: RuleRequired())
                $0.add(rule: RuleEmail())
                $0.validationOptions = .validatesOnBlur
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< PasswordRow("PasswordRowTag") {
                $0.title = "Password"
                $0.add(rule: RuleMinLength(minLength: 8))
                $0.add(rule: RuleMaxLength(maxLength: 24))
                $0.validationOptions = .validatesOnBlur
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            
            +++ Section("Other")
            <<< PickerInputRow<String>("LocationRowTag") {
                $0.title = "Location"
                $0.options = ["Japan", "Other"]
        }
        
        // If you don't want to use Eureka custom operators ...
        //        let row = NameRow("NameRow") { $0.title = "name" }
        //        let section = Section()
        //        section.append(row)
        //        form.append(section)
        //
    }
    
    @objc func didTapSaveButton(sender: UIBarButtonItem) {
        let errors = form.validate()
        guard errors.isEmpty else {
            print("validate errors:", errors)
            return
        }
        
        // Get the value of a single row
        let nameRow = form.rowBy(tag: "NameRowTag") as! NameRow
        let name = nameRow.value!
        
        // Get the value of all rows which have a Tag assigned
        let values = form.values()
        
        let birthday = DateFormatter.localizedString(from: values["BirthdayRowTag"] as! Date,
                                                     dateStyle: .short,
                                                     timeStyle: .none)
        let email = values["EmailRowTag"] as! String
        //        let password = values["PasswordRowTag"] as! String
        let location = values["LocationRowTag"] as! String
        
        let message =
            "Name:" + name + "\n" +
                "Birthday:" + birthday + "\n\n" +
                "Email:" + email + "\n" +
                "Password:" + "●●●●●●" + "\n\n" +
                "Location:" + location
        
        let alert = UIAlertController(title: "Row values",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func setupViews() {
//        bottomButtonView.button.setTitle("完了する", for: .normal)
//        bottomButtonView.button.addTarget(self, action: #selector(tapButton(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc func tapButton(_ sender: UIButton) {
        presenter.didTapBottomButton()
    }
    
    @IBAction func tapCloseButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension TodoInputFormViewController: TodoInputPresenterOutput {
    func transitionToNextViewController(selectedDate: String) {
        self.dismiss(animated: true, completion: nil)
    }

}
