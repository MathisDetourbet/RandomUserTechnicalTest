//
//  ApiInformation.swift
//  RandomUser
//
//  Created by Mathis Detourbet on 30/12/19.
//  Copyright © 2019 Mathis Detourbet. All rights reserved.
//

import Foundation

struct ApiInformations {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}

extension ApiInformations: Decodable {
    
    enum ApiInformationsCodingKeys: String, CodingKey {
        case seed
        case results
        case page
        case version
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ApiInformationsCodingKeys.self)
        
        seed = try container.decode(String.self, forKey: .seed)
        results = try container.decode(Int.self, forKey: .results)
        page = try container.decode(Int.self, forKey: .page)
        version = try container.decode(String.self, forKey: .version)
    }
}
