//
//  ResponseAuth.swift
//  CloudMovie
//
//  Created by Edwin Alvarado on 11/11/19.
//  Copyright © 2019 tbx. All rights reserved.
//

import Foundation

struct ResponseAuth: Codable {
    
    var sub: String? = ""
    var token: String? = ""
    var type: String? = ""
    
    enum CodingKeys: String, CodingKey{
        case sub, token, type
    }
}
