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
    
    private var nsDefaults = NSUserDefaults()
    
    class var sharedInstance: UserDefaults {
        struct Singleton {
            static let instance = UserDefaults()
        }
        return Singleton.instance
    }
    
    init() {
        nsDefaults = NSUserDefaults.standardUserDefaults()
        nsDefaults.setBool(true, forKey: DataUserDefaults.autoLogin)
    }
    
    
    internal func Save(username: String, password: String) {
        nsDefaults.setObject(username, forKey: DataUserDefaults.userName)
        nsDefaults.setObject(password, forKey: DataUserDefaults.password)
        nsDefaults.setBool(true, forKey: DataUserDefaults.autoLogin)
        nsDefaults.synchronize()
    }
    
    internal func login() -> Bool {
        let user = nsDefaults.stringForKey(DataUserDefaults.userName)
        let password = nsDefaults.stringForKey(DataUserDefaults.password)
        
        return user != nil && password != nil
    }
    
    internal func autoLogin() -> Bool {
        return nsDefaults.boolForKey(DataUserDefaults.autoLogin)
    }
}
