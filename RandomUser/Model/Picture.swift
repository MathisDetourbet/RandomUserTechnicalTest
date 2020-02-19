//
//  Picture.swift
//  RandomUser
//
//  Created by Mathis Detourbet on 30/12/19.
//  Copyright © 2019 Mathis Detourbet. All rights reserved.
//

import Foundation

struct Picture {
    let large: URL?
    let medium: URL?
    let thumbnail: URL?
}

extension Picture: Decodable {
    
    enum PictureCodingKeys: String, CodingKey {
        case large
        case medium
        case thumbnail
    }
    
    init(from decodeur: Decoder) throws {
        let container = try decodeur.container(keyedBy: PictureCodingKeys.self)
        
        large = URL(string: try container.decode(String.self, forKey: .large))
        medium = URL(string: try container.decode(String.self, forKey: .medium))
        thumbnail = URL(string: try container.decode(String.self, forKey: .thumbnail))
    }
}
