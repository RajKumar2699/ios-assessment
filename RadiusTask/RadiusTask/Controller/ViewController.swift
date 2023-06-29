//
//  ViewController.swift
//  RadiusTask
//
//  Created by ADMIN on 28/06/23.
//  Copyright © 2023 Kiwitech. All rights reserved.
//

import UIKit

// MARK: - View Controller

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.dataSource = self
        tableView?.delegate = self
        
        viewModel.delegate = self
        viewModel.loadData()
    }
}

