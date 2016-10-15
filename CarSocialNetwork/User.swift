//
//  user.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/30/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import Parse

class User: PFObject, PFSubclassing {
    
    @NSManaged var username: String
    @NSManaged var password: String
    @NSManaged var email: String
    @NSManaged var profileImage: PFFile
    @NSManaged var thumbImage: PFFile
    @NSManaged var car: Car
    
    fileprivate var imageProfile: UIImage!
    fileprivate var imageThumb: UIImage!
    
    init(username: String, password: String, email: String) {
        super.init()
        self.email = email
        self.username = username
        self.password = password
    }
    static func parseClassName() -> String {
        return "User"
    }
}
