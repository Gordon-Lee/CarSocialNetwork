//
//  Usr.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio on 25/10/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import Foundation
import Parse
import UIKit

class Usr {
    
    var objId: String?
    var userName: String?
    var password: String?
    var email: String?
    var thumbImage: PFFile?
    var profilePhoto: PFFile?
    var thumbI: UIImage?
    var profPhoto: UIImage?
    
//    init(obejctId: String, username: String?, email: String?, thumbImage: PFFile?, photo: PFFile?, load: Bool) {
//        self.objId = obejctId
//        self.userName = username
//        self.email = email
//        
//        thumbImage?.getDataInBackground(block: { (data, error) in
//            if let image = UIImage(data: data!) {
//                self.thumbI = image
//                return
//            }
//        })
//        
//        photo?.getDataInBackground(block: { (data, error) in
//            if let image = UIImage(data: data!) {
//                self.profPhoto = image
//            }
//        })
//    }
    
    init() { }
    
    init(obejctId: String?, username: String?, email: String?, thumbImage: PFFile?, photo: PFFile?) {
        self.objId = obejctId
        self.userName = username
        self.email = email
        self.thumbImage = thumbImage
        self.profilePhoto = photo
    }
}
