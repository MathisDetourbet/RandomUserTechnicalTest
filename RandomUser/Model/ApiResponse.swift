//
//  ApiResponse.swift
//  RandomUser
//
//  Created by Mathis Detourbet on 30/12/19.
//  Copyright © 2019 Mathis Detourbet. All rights reserved.
//

import Foundation

struct ApiResponse<T: Decodable> {
    let results: [T]
    let info: ApiInformations
}

extension ApiResponse: Decodable {
    
    enum ApiResponseCodingKeys: String, CodingKey {
        case results
        case info
    }
    
    init(from decodeur: Decoder) throws {
        let container = try decodeur.container(keyedBy: ApiResponseCodingKeys.self)
        
        results = try container.decode([T].self, forKey: .results)
        info = try container.decode(ApiInformations.self, forKey: .info)
    }
}

