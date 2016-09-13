//
//  Photo.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/12/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import Parse

class Photo: PFObject, PFSubclassing {
    
    @NSManaged var owner: PFUser
    @NSManaged var image: PFFile
    @NSManaged var thumbImage: PFFile
    
    let targetImage = CGSize(width: 400, height: 400)
    let thumbTargetImage = CGSize(width: 100, height: 100)
    
    static func parseClassName() -> String {
        return "Photo"
    }
}

