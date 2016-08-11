//
//  User.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/11/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import Parse

class User: PFObject, PFSubclassing {
    @NSManaged var username: String!
    @NSManaged var password: String!
    @NSManaged var email: String!
    @NSManaged var profilephoto: PFFile!
    @NSManaged var profilephotoNormal: PFFile!
    
    static func parseClassName() -> String {
        return "_User"
    }
    
}