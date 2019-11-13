//
//  MoviesDTO.swift
//  CloudMovie
//
//  Created by Edwin Alvarado on 11/11/19.
//  Copyright © 2019 tbx. All rights reserved.
//

import Foundation

struct MoviesDTO: Codable {
    
    var title: String? = ""
    var imageUrl: String? = ""
    var videoUrl: String? = ""
    var description: String? = ""

    enum CodingKeys: String, CodingKey{
        case title, imageUrl, videoUrl, description
    }
    
}
