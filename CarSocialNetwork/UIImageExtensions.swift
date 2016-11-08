//
//  UIViewExtensions.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio on 15/10/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit

extension UIImageView {
    func setCircle() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    func serRounded() {
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
    }
}
