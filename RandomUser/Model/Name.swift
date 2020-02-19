//
//  Name.swift
//  
//
//  Created by Mathis Detourbet on 30/12/19.
//

import Foundation

struct Name {
    let first: String
    let last: String
}

extension Name: Decodable {
    
    enum NameCodingKeys: String, CodingKey {
        case first
        case last
    }
    
    init(from decodeur: Decoder) throws {
        let container = try decodeur.container(keyedBy: NameCodingKeys.self)
        
        first = try container.decode(String.self, forKey: .first)
        last = try container.decode(String.self, forKey: .last)
    }
}
