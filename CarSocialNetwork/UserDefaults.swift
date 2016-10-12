//
//  UserDefaults.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import Foundation

struct DataUserDefaults {
    static let userName = "username"
    static let password = "password"
    static let autoLogin = "autoLogin"
}

class UserDefaults {
    
    fileprivate var nsDefaults = Foundation.UserDefaults()
    
    class var sharedInstance: UserDefaults {
        struct Singleton {
            static let instance = UserDefaults()
        }
        return Singleton.instance
    }
    
    init() {
        nsDefaults = Foundation.UserDefaults.standard
        nsDefaults.set(false, forKey: DataUserDefaults.autoLogin)
    }
    
    internal func Save(_ username: String, password: String) {
        nsDefaults.set(username, forKey: DataUserDefaults.userName)
        nsDefaults.set(password, forKey: DataUserDefaults.password)
        nsDefaults.set(true, forKey: DataUserDefaults.autoLogin)
        nsDefaults.synchronize()
    }
    
    internal func login() -> Bool {
        let user = nsDefaults.string(forKey: DataUserDefaults.userName)
        let password = nsDefaults.string(forKey: DataUserDefaults.password)
        
        return user != nil && password != nil
    }
    
    internal func autoLogin() -> Bool {
        return nsDefaults.bool(forKey: DataUserDefaults.autoLogin)
    }
    
    internal func setAutoLogin(_ autoLogin: Bool) {
        nsDefaults.set(autoLogin, forKey: DataUserDefaults.autoLogin)
    }
}
