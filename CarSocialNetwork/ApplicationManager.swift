//
//  ApplicationManager.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 9/13/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import Foundation
import Parse

class ApplicationManager {
    
    private var appManager = ApplicationManager()
    
    class var sharedInstance: ApplicationManager {
        struct Singleton {
            static let instance = ApplicationManager()
        }
        return Singleton.instance
    }
    
    func getCurrentUserId() -> String {
        return (PFUser.currentUser()?.objectId!)!
    }
    
    func getCurrentuserName() -> String {
        return (PFUser.currentUser()?.username)!
    }
    
    func getUser() {
        PFUser.currentUser()?.fetchInBackgroundWithBlock({ (current, error) in
            if let user = current as? PFUser where error != nil {
                print(user.username)
                print(user["profileImage"])
            }
        })
    }
}
