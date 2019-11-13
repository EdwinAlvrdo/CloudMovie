//
//  AuthService.swift
//  CloudMovie
//
//  Created by Edwin Alvarado on 11/11/19.
//  Copyright © 2019 tbx. All rights reserved.
//

import Foundation
import Moya

enum AuthService {
    case login(_ key: String)
}

extension AuthService: TargetType {
    var baseURL: URL {
        return Endpoints.SERVER_URL
    }
    
    var path: String {
        return Endpoints.Routes.Auth.LOGIN
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .login(let authKey):
            return .requestParameters(parameters: [Endpoints.Params.SUB: authKey], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return Endpoints.generalHeader
    }
}
