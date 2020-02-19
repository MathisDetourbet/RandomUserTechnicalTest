//
//  RandomUser.swift
//  RandomUser
//
//  Created by Mathis Detourbet on 30/12/19.
//  Copyright © 2019 Mathis Detourbet. All rights reserved.
//

import Foundation

struct RandomUser {
    let name: Name
    let email: String
    let picture: Picture
}

extension RandomUser: Decodable {
    
    enum RandomUserCodingKeys: String, CodingKey {
        case name
        case email
        case picture
    }
    
    init(from decodeur: Decoder) throws {
        let container = try decodeur.container(keyedBy: RandomUserCodingKeys.self)
        
        name = try container.decode(Name.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        picture = try container.decode(Picture.self, forKey: .picture)
    }
}

extension RandomUser: Encodable {
    
    func encode(to encoder: Encoder) throws {
        
    }
}
