//
//  EventsViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio on 15/10/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Fusuma

class EventsViewController: UIViewController {
    
    fileprivate var eveventRegister: EventDescriptionView!
    fileprivate var fusuma: FusumaViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        fusuma = FusumaViewController()
    }
}

extension EventsViewController : FusumaDelegate {
    
    func fusumaImageSelected(_ image: UIImage) {
        print("IMAGE SELECTED CAR")
    }
    
    func fusumaDismissedWithImage(_ image: UIImage) {
        print("Called just after FusumaViewController is dismissed.")
       
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        print("Called just after a video has been selected.")
    }
    
    func fusumaCameraRollUnauthorized() {
        print("Camera roll unauthorized")
    }
}

extension EventsViewController: EventsDelegate {
    func saveEvent(event: Events) {
        event.saveInBackground()
    }
}
