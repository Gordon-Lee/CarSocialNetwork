//
//  AutoLogin.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio on 08/11/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit

class AutoLogin: UISwitch {

    override func awakeFromNib() {
        isOn = !UserDefaults.sharedInstance.autoLogin()
        isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(isOn)
    }
}
