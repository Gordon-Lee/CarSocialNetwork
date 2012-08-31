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
    @NSManaged var profileImage: PFFile
    @NSManaged var thumbImage: PFFile
    @NSManaged var car: Car
    
    //TODO VER NOME CORRETO
    static func parseClassName() -> String {
        return "_User"
    }
}