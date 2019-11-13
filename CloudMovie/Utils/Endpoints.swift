//
//  Constants.swift
//  CloudMovie
//
//  Created by Edwin Alvarado on 11/11/19.
//  Copyright © 2019 tbx. All rights reserved.
//

import Foundation
import Result
import Moya

class Endpoints {
    
    static let BASE_URL: String = "https://echo-serv.tbxnet.com"
    static let API_VERION: String = "/v1"
    static let API_KEY: String = "ToolboxMobileTest"
    
    static var SERVER_URL: URL {
        return URL(string: BASE_URL + API_VERION)!
    }
    
    enum internalResponse {
        case success(response: Moya.Response)
        case error(response: Moya.Response)
        case logout
        case failure
    }
    
    static var generalHeader: [String: String] {
        return ["Content-Type": "application/json"]
    }
    
    static var sessionHeader: [String: String] {
        return ["Content-Type": "application/json",
                "Authorization": "\(UserDefaultsManager.getTypeAuth()) \(UserDefaultsManager.getToken())"]
    }
    
    class Params {
        static var SUB: String = "sub"
    }
    
    class Routes {
        class Auth {
            static var LOGIN: String = "/mobile/auth"
        }
        
        class Movie {
            static var PACKMOVIES: String = "/mobile/data"
        }
    }
    
}

extension Endpoints { // Endpoint Utilities

    static func proccessResult(result: Result<Response, MoyaError>) -> internalResponse {
        switch result {
        case .success(let response): //Check response
            //Another option if response.statusCode < 300 >> Success! :)
            switch response.statusCode{
            case 200, 201, 202, 203, 204, 205, 207, 208, 226:
                return internalResponse.success(response: response)
            case 400, 401, 402, 403:
                //TODO: Delete token and Logout
                print("Unauthorized")
                return internalResponse.logout
            default:
                var responseError : ResponseError?
                do {
                    responseError = try JSONDecoder().decode(ResponseError.self, from: response.data)
                    print("Error:  \(responseError?.message) ")
                    return internalResponse.error(response: response)
                }catch{
                    print("Unknow error ocurrs") //Maybe another type of this enum
                    return internalResponse.failure
                }
            }
        case .failure(let error): //Checking error and print in a message whats happend
            print(error)
            return internalResponse.failure
        }
    }
}
