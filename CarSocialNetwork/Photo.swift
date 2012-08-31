//
//  Photo.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/12/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import Parse

class Photo: PFObject, PFSubclassing {
    
    @NSManaged var owner: User
    @NSManaged var image: PFFile
    @NSManaged var thumbImage: PFFile
    
    static func parseClassName() -> String {
        return "Photo"
    }
}

