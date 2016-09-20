//
//  ActivityType.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 9/20/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

enum ActivityType: Int {
    case Post, Like, Liked
    
    var name: String {
        switch self {
        case .Post:
            return "Postou"
        case .Like:
            return "Gostou"
        case .Liked:
            return "Gostei"
        }
    }
}
