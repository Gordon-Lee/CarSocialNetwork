//
//  AppColor.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.


import UIKit

class AppCongifuration {
    static func systemBars() {
        UITabBar.appearance().tintColor = AppCongifuration.blue()
        UITabBar.appearance().backgroundColor = AppCongifuration.darkGrey()
        
        UINavigationBar.appearance().backgroundColor = AppCongifuration.amostBlack()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: AppCongifuration.darkGrey()]
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 21)!]
    }
    static func amostBlack() -> UIColor {
        return UIColor(red: 11/255, green: 11/255, blue: 11/255, alpha: 1.0)
    }
    static func blue() -> UIColor {
        return UIColor(red: 54/255, green: 165/255, blue: 230/255, alpha: 1.0)
    
    }
    static func lightGrey() -> UIColor {
        return UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1.0)
    }
    static func darkGrey() -> UIColor {
        return UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
    }
    static func white() -> UIColor {
        return UIColor(red: 255/255, green: 255/255, blue: 245/255, alpha: 1.0)
    }
    
}