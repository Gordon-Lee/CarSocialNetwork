//
//  EventsViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio on 15/10/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Fusuma
import Parse

class EventsViewController: UIViewController {
    
    static let identifier = "Events"
    
    @IBOutlet weak var addPhoto: UIButton!
    @IBOutlet weak var imageSelected: UIImageView!
    @IBOutlet weak var eventDescription: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var adress: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    
    
    fileprivate var fusuma: FusumaViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        fusuma = FusumaViewController()
        fusuma.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupView()
    }
    
    fileprivate func setupView() {
        FusumaConfig.defaultCfg()
    
        view.backgroundColor = AppCongifuration.darkGrey()
        title = "Novo Evento"
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    @IBAction func showFusuma(_ sender: Any) {
        present(fusuma, animated: true, completion: nil)
    
    }
    @IBAction func newEvent(_ sender: Any) {
        save()
    }

    
    func save() {
        
        let eventToSave = Events(onwer: PFUser.current()!,
                                 name: name.text!,
                                 eventDescription: eventDescription.text!,
                                 image: PFFile(data: AdjustPhoto.uploadToPhoto(imageSelected.image!, type: .normal))!,
                                 local: adress.text!,
                                 cidade: city.text!,
                                 estado: state.text!)
        eventToSave.saveInBackground()
    }
}

extension EventsViewController : FusumaDelegate {
    
    func fusumaImageSelected(_ image: UIImage) {
        print("IMAGE SELECTED CAR")
    }
    
    func fusumaDismissedWithImage(_ image: UIImage) {
        print("Called just after FusumaViewController is dismissed.")
        imageSelected.image = image
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
