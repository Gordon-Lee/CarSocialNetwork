//
//  ActivityType.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 9/20/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

enum ActivityType: Int {
    case post, like, liked
    
    var name: String {
        switch self {
        case .post:
            return "Postou"
        case .like:
            return "Gostou"
        case .liked:
            return "Gostei"
        }
    }
}
