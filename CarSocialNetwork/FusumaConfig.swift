//
//  FusumaConfig.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio on 15/10/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import Foundation
import Fusuma

class  FusumaConfig {
    static func defaultCfg() {
        fusumaCameraTitle = "Camera"
        fusumaCameraRollTitle = "Biblioteca"
        
        fusumaTintColor = AppCongifuration.blue()
        fusumaBaseTintColor = AppCongifuration.lightGrey()
        fusumaBackgroundColor = AppCongifuration.darkGrey()
        
        fusumaAlbumImage = UIImage(named: "photoLibrary2.png")
        fusumaCameraImage = UIImage(named: "camera.png")
        fusumaCheckImage = UIImage(named: "ok.png")
        fusumaCloseImage = UIImage(named: "cancel1.png")
        fusumaFlashOnImage = UIImage(named: "flashOn.png")
        fusumaFlashOffImage = UIImage(named: "flashOff.png")
        fusumaFlipImage = UIImage(named: "refresh.png")
    }
}

