//
//  Event.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import Parse

class Events: PFObject, PFSubclassing {
    
    @NSManaged var onwer: PFUser
    @NSManaged var name: String
    @NSManaged var eventDescription: String
    @NSManaged var startDate: Date
    @NSManaged var endDate: Date
    @NSManaged var image: PFFile
    
    override init() { super.init() }
    
    init(onwer: PFUser, name: String, eventDescription: String, image: PFFile) {
        super.init()
        self.onwer = onwer
        self.name = name
        self.eventDescription = eventDescription
        self.image = image
    }
    
    static func parseClassName() -> String {
        return "Events"
    }
}
