//
//  File.swift
//  CloudMovie
//
//  Created by Edwin Alvarado on 11/11/19.
//  Copyright © 2019 tbx. All rights reserved.
//

import Foundation
import Moya

enum MovieService {
    case moviePacks
}

extension MovieService: TargetType {
    var baseURL: URL {
        return Endpoints.SERVER_URL
    }
    
    var path: String {
        return Endpoints.Routes.Movie.PACKMOVIES
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return Endpoints.sessionHeader
    }
}
