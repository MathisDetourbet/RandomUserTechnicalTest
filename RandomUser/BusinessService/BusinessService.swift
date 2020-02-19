//
//  BusinessService.swift
//  RandomUser
//
//  Created by Mathis Detourbet on 30/12/19.
//  Copyright © 2019 Mathis Detourbet. All rights reserved.
//

import Foundation
import Connectivity

class BusinessService {
    private let connectivity = Connectivity()
    private let apiDataAccess: ApiDataAccess
    private let localStorageDataAccess: UserDefaultsDataAccess
    
    private let randomUserRange = 50
    
    init(apiDataAccess: ApiDataAccess, localStorageDataAccess: UserDefaultsDataAccess) {
        self.apiDataAccess = apiDataAccess
        self.localStorageDataAccess = localStorageDataAccess
    }
    
    func fetchBunchOfRandomUser(currentPage: Int, completion: @escaping CompletionHandler<[RandomUser]>) {
        connectivity.checkConnectivity { [weak self] connectivity in
            guard let self = self else {
                return
            }
            switch connectivity.status {
            case .connected, .connectedViaWiFi, .connectedViaCellular:
                // Use the api to fetch random users
                self.apiDataAccess.fetchBunchRandomUser(with: currentPage, count: self.randomUserRange, completion: { (result: Result<[RandomUser]>) in
                    completion(result)
                })
            default:
                // Use local storage to fetch random users
                self.localStorageDataAccess.fetchBunchRandomUser(with: currentPage, count: self.randomUserRange, completion: { (result: Result<[RandomUser]>) in
                    completion(result)
                })
            }
        }
    }
}
