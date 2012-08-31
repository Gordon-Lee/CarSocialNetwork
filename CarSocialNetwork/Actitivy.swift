//
//  Actitivy.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/30/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import Parse

class Activity: PFObject, PFSubclassing {
    
    @NSManaged var fromUser: User
    @NSManaged var toUser: User
    @NSManaged var image: PFFile
    @NSManaged var type: String
    @NSManaged var content: String
 
    static func parseClassName() -> String {
        return "Activity"
    }
}
