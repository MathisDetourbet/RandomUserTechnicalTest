//
//  ApiConfiguration.swift
//  RandomUser
//
//  Created by Mathis Detourbet on 30/12/19.
//  Copyright © 2019 Mathis Detourbet. All rights reserved.
//

import Foundation

struct ApiConfiguration: Configuration {
    private let protocolType = "https://"
    private let apiDomain = "randomuser.me/"
    private let service = "api/"
    
    var baseUrl: String {
        return protocolType + apiDomain + service
    }
}
