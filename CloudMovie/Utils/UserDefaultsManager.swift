//
//  UserDefaults.swift
//  CloudMovie
//
//  Created by Edwin Alvarado on 11/12/19.
//  Copyright © 2019 tbx. All rights reserved.
//

import Foundation
import UIKit

class UserDefaultsManager {
    
    static func saveToken(_ value: String){
        UserDefaults.standard.set(value, forKey:"token")
    }
    
    static func getToken() -> String {
        return UserDefaults.standard.string(forKey: "token") ?? ""
    }
    
    static func removeAuth() {
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "typeAuth")
    }
    
    static func saveTypeAuth(_ value: String){
        UserDefaults.standard.set(value, forKey:"typeAuth")
    }
    
    static func getTypeAuth() -> String {
        return UserDefaults.standard.string(forKey: "typeAuth") ?? ""
    }
    
}
