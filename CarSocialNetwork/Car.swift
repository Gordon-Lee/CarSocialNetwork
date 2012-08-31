//
//  Car.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import Parse

class Car: PFObject, PFSubclassing {
    
    @NSManaged var brand: String
    @NSManaged var model: String
    @NSManaged var year: Int
    @NSManaged var image: PFFile
    @NSManaged var thumbImage: PFFile
    
    static func parseClassName() -> String {
        return "Car"
    }
    
}
