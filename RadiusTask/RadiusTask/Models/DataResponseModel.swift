//
//  DataResponseModel.swift
//  RadiusTask
//
//  Created by ADMIN on 28/06/23.
//  Copyright © 2023 Kiwitech. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct DataResponseModel: Decodable {
    var facilities: [Facility]
    var exclusions: [[Exclusion]]
}

// MARK: - Exclusion
struct Exclusion: Decodable {
    var facilityID, optionsID: String
    
    enum CodingKeys: String, CodingKey {
        case facilityID = "facility_id"
        case optionsID = "options_id"
    }
}

// MARK: - Facility
struct Facility: Decodable {
    var facilityID, name: String
    var options: [Option]
    
    enum CodingKeys: String, CodingKey {
        case facilityID = "facility_id"
        case name, options
    }
}

// MARK: - Option
struct Option: Decodable {
    var name, icon, id: String
}
