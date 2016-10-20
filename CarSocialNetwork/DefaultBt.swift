//
//  Default.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 9/12/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit

class DefaultBt: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = 5
        layer.backgroundColor = AppCongifuration.mediumGrey().cgColor
        layer.borderWidth = 2
        layer.borderColor = AppCongifuration.darkGrey().cgColor
        setTitleColor(AppCongifuration.darkGrey(), for: UIControlState())
    }
}
