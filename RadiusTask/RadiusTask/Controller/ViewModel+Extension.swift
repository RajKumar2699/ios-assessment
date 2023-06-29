//
//  ViewModel+Extension.swift
//  RadiusTask
//
//  Created by ADMIN on 29/06/23.
//  Copyright © 2023 Kiwitech. All rights reserved.
//

import Foundation

extension ViewModel {
    
    func handleSelection(for facilityID: String, with optionID: String) {
        selectedOptions[facilityID] = optionID
        
        for exclusion in dataArray?.exclusions ?? [] {
            let firstExclusion = exclusion[0]
            let secondExclusion = exclusion[1]
            
            if selectedOptions[firstExclusion.facilityID] == firstExclusion.optionsID {
                if selectedOptions[secondExclusion.facilityID] == secondExclusion.optionsID {
                    selectedOptions[secondExclusion.facilityID] = nil
                }
            }
            
            if selectedOptions[secondExclusion.facilityID] == secondExclusion.optionsID {
                if selectedOptions[firstExclusion.optionsID] == firstExclusion.optionsID {
                    selectedOptions[firstExclusion.facilityID] = nil
                }
            }
        }
    }
}
