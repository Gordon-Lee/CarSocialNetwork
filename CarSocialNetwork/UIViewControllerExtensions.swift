//
//  UIViewControllerExtensions.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio on 15/10/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dissmisKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc fileprivate func dissmisKeyboard() {
        view.endEditing(true)
    }
}

extension UIView {
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dissmisKeyboard))
        self.addGestureRecognizer(tap)
    }
    @objc fileprivate func dissmisKeyboard() {
        self.endEditing(true)
    }
}
