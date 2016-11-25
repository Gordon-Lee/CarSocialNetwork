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
    @NSManaged var local: String
    @NSManaged var cidade: String
    @NSManaged var estado: String
    @NSManaged var inicialDate: String
    @NSManaged var endedDate: String
    @NSManaged var address: String
    @NSManaged var image: PFFile
    
    override init() { super.init() }
    
    init(onwer: PFUser,
         name: String, eventDescription: String,
         image: PFFile, local: String, cidade: String, estado: String) {
        super.init()
        self.onwer = onwer
        self.name = name
        self.eventDescription = eventDescription
        self.image = image
        self.address = local
        self.cidade = cidade
        self.estado = estado
    }
    
    static func parseClassName() -> String {
        return "Events"
    }
}
