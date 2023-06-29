//
//  ViewController+Extension.swift
//  RadiusTask
//
//  Created by ADMIN on 29/06/23.
//  Copyright © 2023 Kiwitech. All rights reserved.
//

import UIKit

// MARK: - UITableViewDataSource and UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! TableViewCell
        
        let facility = viewModel.dataSource[indexPath.section]
        let option = facility.options[indexPath.row]
        
        cell.configure(with: option)
        
        if let selectedOptionId = viewModel.selectedOptions[facility.facilityID], selectedOptionId == option.id {
            cell.radioBtnLbl.isSelected = true
            cell.radioBtnLbl.setImage(UIImage(named: Constants.radioBtnActiveImageName), for: .normal)
        } else {
            cell.radioBtnLbl.isSelected = false
            cell.radioBtnLbl.setImage(UIImage(named: Constants.radioBtnInactiveImageName), for: .normal)
        }
        
        cell.selectionHandler = { [weak self] in
            guard let strongSelf = self else {
                return
            }
            
            if facility.facilityID == "2" || facility.facilityID == "3" {
                let propertyTypeOptionID = strongSelf.viewModel.selectedOptions["1"]
                if propertyTypeOptionID == nil {
                    strongSelf.showAlert(title: Constants.propertyTypeNotSelectedTitle, message: Constants.propertyTypeNotSelectedMessage)
                    return
                } else {
                    let exclusions = strongSelf.viewModel.dataArray?.exclusions ?? []
                    for exclusion in exclusions {
                        let firstExclusion = exclusion[0]
                        let secondExclusion = exclusion[1]
                        
                        if firstExclusion.facilityID == facility.facilityID, strongSelf.viewModel.selectedOptions[firstExclusion.facilityID] == firstExclusion.optionsID, strongSelf.viewModel.selectedOptions[secondExclusion.facilityID] == secondExclusion.optionsID {
                            strongSelf.showAlert(title: Constants.exclusionConflictTitle, message: Constants.exclusionConflictMessage)
                            return
                        }
                        
                        if secondExclusion.facilityID == facility.facilityID, strongSelf.viewModel.selectedOptions[secondExclusion.facilityID] == secondExclusion.optionsID, strongSelf.viewModel.selectedOptions[firstExclusion.facilityID] == firstExclusion.optionsID {
                            strongSelf.showAlert(title: Constants.exclusionConflictTitle, message: Constants.exclusionConflictMessage)
                            return
                        }
                    }
                }
            }
            
            let exclusions = strongSelf.viewModel.dataArray?.exclusions ?? []
            for exclusion in exclusions {
                let firstExclusion = exclusion[0]
                let secondExclusion = exclusion[1]
                
                if firstExclusion.facilityID == facility.facilityID, secondExclusion.facilityID == facility.facilityID, strongSelf.viewModel.selectedOptions[firstExclusion.facilityID] == firstExclusion.optionsID, strongSelf.viewModel.selectedOptions[secondExclusion.facilityID] == secondExclusion.optionsID {
                    strongSelf.showAlert(title: Constants.exclusionConflictTitle, message: Constants.exclusionConflictMessage)
                    return
                }
            }
            
            strongSelf.viewModel.handleSelection(for: facility.facilityID, with: option.id)
            strongSelf.tableView.reloadData()
        }
        
        return cell
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.alertOKButtonTitle, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let facility = viewModel.dataSource[section]
        return facility.name
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Constants.defaultRowHeight)
    }
}
