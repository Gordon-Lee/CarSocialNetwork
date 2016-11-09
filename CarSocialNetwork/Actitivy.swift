//
//  Actitivy.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/30/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import Parse

//enum activityType: String {
//    case post, like, liked, goEvent
//
//    var name: String {
//        switch self {
//        case .post:
//            return "Postou"
//        case .like:
//            return "Gostou"
//        case .liked:
//            return "Gostei"
//        case .goEvent:
//            return "Evento"
//        }
//    }
//}
//post, like, liked, goEvent
class Activity: PFObject, PFSubclassing {
    
    @NSManaged var fromUser: PFUser
    @NSManaged var toUser: PFUser
    @NSManaged var image: Photo
    @NSManaged var event: Events
    @NSManaged var type: String
    @NSManaged var content: String
    @NSManaged var activityType: Int
    
    static let typeaString = "activityType"
    
    static func parseClassName() -> String {
        return "Activity"
    }
}
