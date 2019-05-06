//
//  TaskViewViewController.swift
//  todoApp
//
//  Created by RIVER on 2019/05/06.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import UIKit

class TaskViewViewController: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private lazy var calendarViewController: CalendarViewController = {
        let calendarVC = UIStoryboard(
            name: "Calendar",
            bundle: Bundle.main)
            .instantiateInitialViewController() as! CalendarViewController
        let model = CalendarModel()
        let presenter = CalendarPresenter(view: calendarVC, model: model)
        calendarVC.inject(presenter: presenter)
        
        add(asChildViewController: calendarVC)
        return calendarVC
    }()
    
    private lazy var listViewController: ListViewController = {
        let listVC = UIStoryboard(
            name: "List",
            bundle: Bundle.main)
            .instantiateInitialViewController() as! ListViewController
        let model = ListModel()
        let presenter = ListPresenter(view: listVC, model: model)
        listVC.inject(presenter: presenter)
        
        add(asChildViewController: listVC)
        return listVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: listViewController)
            add(asChildViewController: calendarViewController)
        } else {
            remove(asChildViewController: calendarViewController)
            add(asChildViewController: listViewController)
        }
    }
    
    @IBAction func tapSegmentedControl(_ sender: UISegmentedControl) {
        setupViews()
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }

}
