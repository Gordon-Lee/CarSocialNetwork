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
        layer.backgroundColor = AppCongifuration.lightGrey().CGColor
        layer.borderWidth = 1
        layer.borderColor = AppCongifuration.blue().CGColor
        setTitleColor(AppCongifuration.darkGrey(), forState: .Normal)
        setTitleColor(AppCongifuration.amostBlack(), forState: .Highlighted)
    }
}
