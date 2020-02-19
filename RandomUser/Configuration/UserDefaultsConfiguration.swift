//
//  UserDefaultsConfiguration.swift
//  RandomUser
//
//  Created by Mathis Detourbet on 30/12/19.
//  Copyright © 2019 Mathis Detourbet. All rights reserved.
//

import Foundation

struct UserDefaultsConfiguration: Configuration {
    var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    var baseUrl: String {
        return "randomUserPath"
    }
}
