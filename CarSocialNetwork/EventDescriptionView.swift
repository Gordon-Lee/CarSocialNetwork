//
//  EventDescriptionView.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio on 16/10/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Parse
import Fusuma

protocol EventsDelegate: class {
    func saveEvent(event: Events)
}

class EventDescriptionView: UIView {
    
    static let xib = "EventrDescription"

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventDescription: UITextField!
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var name: UITextField!
    
    var delegate: EventsDelegate!
    
    
    
    override func awakeFromNib() {
        endEditing(true)
    }

    @IBAction func addPhoto(_ sender: AnyObject) {
    }
 
    @IBAction func eventRegister(_ sender: AnyObject) {
        delegate?.saveEvent(event: Events(onwer: PFUser.current()!,
                                          name: name.text!,
                                          eventDescription: eventDescription.text!,
                                          image: PFFile(data: AdjustPhoto.uploadToPhoto(eventImage.image!, type: .normal))!))
    }
    
    @IBAction func cancelEventRegister(_ sender: AnyObject) {
    }
    
    fileprivate func saveEnvet() {
        let sv = Events(onwer: PFUser.current()!,
                          name: name.text!,
                          eventDescription: eventDescription.text!,
                          image: PFFile(data: AdjustPhoto.uploadToPhoto(eventImage.image!, type: .normal))!)
        sv.saveInBackground()
    }
}
