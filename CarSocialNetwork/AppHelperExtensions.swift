//
//  AppHelperExtensions.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 25/09/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit

extension UITabBarController {
    
    func tabBarVisibility(_ visible:Bool, animated:Bool) {
        // bail if the current state matches the desired state
        if (tabBarIsVisible() == visible) { return }
        // get a frame calculation ready
        let frame = self.tabBar.frame
        let height = frame.size.height
        let offsetY = (visible ? -height : height)
        // animate the tabBar
        UIView.animate(withDuration: animated ? 0.5 : 0.0, animations: {
            self.tabBar.frame = frame.offsetBy(dx: 0, dy: offsetY)
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height + offsetY)
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
        }) 
    }
    
    func tabBarIsVisible() ->Bool {
        return self.tabBar.frame.origin.y < self.view.frame.maxY
    }
}
