//
//  File.swift
//  CloudMovie
//
//  Created by Edwin Alvarado on 11/11/19.
//  Copyright © 2019 tbx. All rights reserved.
//

import Foundation

struct PackMoviesDTO: Codable {
    
    var title: String? = ""
    var type: String? = ""
    var items: [MoviesDTO]? = [MoviesDTO]()
    
    enum CodingKeys: String, CodingKey{
        case title, type, items
    }
}
