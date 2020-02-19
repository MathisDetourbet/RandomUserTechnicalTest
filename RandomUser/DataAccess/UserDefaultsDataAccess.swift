//
//  UserDefaultsDataAccess.swift
//  RandomUser
//
//  Created by Mathis Detourbet on 30/12/19.
//  Copyright © 2019 Mathis Detourbet. All rights reserved.
//

import Foundation

struct UserDefaultsDataAccess: DataAccess {
    
    let userDefaultsConfiguration: Configuration
    
    init(userDefaultsConfiguration: Configuration) {
        self.userDefaultsConfiguration = userDefaultsConfiguration
    }
    
    func fetchBunchRandomUser(with page: Int, count: Int, completion: @escaping CompletionHandler<[RandomUser]>) {
        
    }
}
