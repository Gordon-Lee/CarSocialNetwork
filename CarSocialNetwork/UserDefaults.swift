//
//  UserDefaults.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import Foundation

enum LoginType: String {
    case normal, facebook
}

struct DataUserDefaults {
    static let userName = "username"
    static let password = "password"
    static let autoLogin = "autoLogin"
    static let loginType = "loginType"
}

struct dataNSUser {
    var username: String
    var password: String
    
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
    }
    
    internal func Save(username: String, password: String, loginType: LoginType) {
        nsDefaults.set(username, forKey: DataUserDefaults.userName)
        nsDefaults.set(password, forKey: DataUserDefaults.password)
        nsDefaults.set(true, forKey: DataUserDefaults.autoLogin)
        nsDefaults.set(loginType.rawValue, forKey: DataUserDefaults.loginType)
        nsDefaults.synchronize()
    }
    
    internal func isFirtTime() -> Bool {
        let user = nsDefaults.string(forKey: DataUserDefaults.userName)
        let password = nsDefaults.string(forKey: DataUserDefaults.password)
        
        return user == nil && password == nil
    }
    
    internal func getUserName() -> String? {
        return nsDefaults.string(forKey: DataUserDefaults.userName)
    }
    
    internal func getPassword() -> String {
        return nsDefaults.string(forKey: DataUserDefaults.password)!
    }
    
    internal func autoLogin() -> Bool {
        return nsDefaults.bool(forKey: DataUserDefaults.autoLogin)
    }
    
    internal func typeOfLogin() -> String {
        return nsDefaults.string(forKey: DataUserDefaults.loginType)!
    }
    
    internal func setAutoLogin(_ autoLogin: Bool) {
        nsDefaults.set(autoLogin, forKey: DataUserDefaults.autoLogin)
    }
}
