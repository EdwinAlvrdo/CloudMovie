//
//  ResponseError.swift
//  CloudMovie
//
//  Created by Edwin Alvarado on 11/11/19.
//  Copyright © 2019 tbx. All rights reserved.
//

import Foundation

struct ResponseError: Codable {
    
    var code: String? = ""
    var message: String? = ""
    
    enum CodingKeys: String, CodingKey{
        case code, message
    }
}
