//
//  DefaultSettings.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio on 26/10/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit

class DefaultSettings: UIImageView {

    override func awakeFromNib() {
        setupView()
    }
    
    fileprivate func setupView() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10.0
    }
}
