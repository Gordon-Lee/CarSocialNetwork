//
//  Event.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import Parse

class Event: PFObject, PFSubclassing {
    
    @NSManaged var onwer: User
    @NSManaged var name: String
    @NSManaged var eventDescription: String
    @NSManaged var endDate: NSDate
    @NSManaged var image: PFFile
    
    static func parseClassName() -> String {
        return "Event"
    }
}
