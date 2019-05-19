//
//  ListViewController.swift
//  todoApp
//
//  Created by RIVER on 2019/04/27.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var presenter: ListPresenterInput!
    
    func inject(presenter: ListPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        
    }

}

extension ListViewController: ListPresenterOutput {
    
}
