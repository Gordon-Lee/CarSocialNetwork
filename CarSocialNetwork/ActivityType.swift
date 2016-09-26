//
//  ActivityType.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 9/20/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

enum ActivityType: Int {
    case POST, LIKE, LIKED
    
    var name: String {
        switch self {
        case .POST:
            return "Postou"
        case .LIKE:
            return "Gostou"
        case .LIKED:
            return "Gostei"
        }
    }
}
