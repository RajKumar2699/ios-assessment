//
//  ViewModel.swift
//  RadiusTask
//
//  Created by ADMIN on 28/06/23.
//  Copyright © 2023 Kiwitech. All rights reserved.
//

import Foundation

// MARK: - ViewModel

protocol ViewModelProtocol: AnyObject {
    func createDataSource()
}

protocol ReloadDataProtocol: AnyObject {
    func tableViewReload()
}

class ViewModel: NSObject, ViewModelProtocol {
    
    var dataSource = [Facility]()
    var dataArray: DataResponseModel?
    var selectedOptions: [String: String] = [:]
    weak var delegate: ReloadDataProtocol?
    
    func loadData() {
        NetworkManager.shared.fetchData { [weak self] dataResponse, error in
            if let error = error {
                print("\(Constants.errorLoadingData) \(error.localizedDescription)")
                return
            }
            if let list = dataResponse {
                self?.dataArray = list
                self?.createDataSource()
            }
        }
    }
    
    func createDataSource() {
        guard let results = dataArray?.facilities else {
            return
        }
        
        self.dataSource = results
        delegate?.tableViewReload()
    }
}
