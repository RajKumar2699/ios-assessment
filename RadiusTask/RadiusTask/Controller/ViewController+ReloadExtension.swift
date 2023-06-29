//
//  ViewController+ReloadExtension.swift
//  RadiusTask
//
//  Created by ADMIN on 29/06/23.
//  Copyright © 2023 Kiwitech. All rights reserved.
//

import Foundation

// MARK: - ReloadDataProtocol

extension ViewController: ReloadDataProtocol {
    func tableViewReload() {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
}
