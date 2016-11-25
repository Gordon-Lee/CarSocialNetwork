//
//  ShowEventViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio on 03/11/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD

var showEvent = Events()

class ShowEventViewController: UIViewController {

    static let identifier = "ShowEventViewController"
    static var look = Bool()
    
   // @IBOutlet weak var event: UILabel!
    @IBOutlet weak var eventDesc: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var save: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Descrição"
        eventImage.serRounded()
        view.backgroundColor = AppCongifuration.lightGrey()
        //title = showEvent.name
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        save.isEnabled = ShowEventViewController.look
    }
    
    fileprivate func loadData() {
//        print(showEvent)
        //event.text = showEvent.name
        eventDesc.text = showEvent.eventDescription
        startDate.text = showEvent.inicialDate
        endDate.text = showEvent.endedDate
        adress.text = showEvent.address
        city.text = showEvent.cidade
        state.text = showEvent.estado
        
//        print(showEvent.image)
        showEvent.image.getDataInBackground { (data, error) in
            if let imgData = UIImage(data: data!) {
                self.eventImage.image = imgData
            }
        }
    }
    @IBAction func saveEvent(_ sender: Any) {
//        let queryGoActivity = Activity.query()
//        queryGoActivity?.includeKey("toUser")
//        queryGoActivity?.includeKey("event")
//        queryGoActivity?.whereKey("toUser", equalTo: PFUser.current()!)
//        queryGoActivity?.whereKey("fromUser", equalTo: showEvent.onwer)
//        queryGoActivity?.whereKe
//        queryGoActivity?.whereKey(Activity.typeaString, contains: "\(activityType.goEvent.rawValue)")
//        
//        queryGoActivity?.findObjectsInBackground(block: { (events, error) in
//            if error == nil {
//                print("eeevvv \(events?.count)")
//            }
//        })
        
        let activityEventUser = Activity()
        activityEventUser.activityType = ActivityType.goEvent.rawValue
        activityEventUser.fromUser = showEvent.onwer
        activityEventUser.toUser = PFUser.current()!
        activityEventUser.event = showEvent
        SVProgressHUD.show()
        activityEventUser.saveInBackground { (success, error) in
            if success {
                self.showAlert()
                SVProgressHUD.dismiss()
            }
        }
    }
    
    fileprivate func showAlert() {
        
        let alert = UIAlertController(title: "Evento", message: "Cadastrado com sucesso", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
