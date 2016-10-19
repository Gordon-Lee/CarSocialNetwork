//
//  EventsViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio on 15/10/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {
    
    fileprivate var eveventRegister: EventDescriptionView!
    fileprivate var eventToSave: Events!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension EventsViewController: EventsDelegate {
    func saveEvent(event: Events) {
        event.saveInBackground()
    }
}
