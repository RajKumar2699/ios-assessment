//
//  NetworkManager.swift
//  RadiusTask
//
//  Created by ADMIN on 28/06/23.
//  Copyright © 2023 Kiwitech. All rights reserved.
//

import Foundation

// MARK: - Network Manager

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = Constants.baseURL
    
    private init() {}
    
    func fetchData(completion: @escaping (DataResponseModel?, Error?) -> ()) {
        guard let url = URL(string: Constants.baseURL) else {
            let error = NSError(domain: Constants.invalidURLDomain, code: Constants.invalidURLCode, userInfo: nil)
            completion(nil, error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: Constants.emptyResponseDomain, code: Constants.invalidURLCode, userInfo: nil)
                completion(nil, error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dataResponse = try decoder.decode(DataResponseModel.self, from: data)
                completion(dataResponse, nil)
                print(dataResponse)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil, error)
            }
        }
        
        task.resume()
    }
}
