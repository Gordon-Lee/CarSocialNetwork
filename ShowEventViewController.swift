//
//  ShowEventViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio on 03/11/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit

var showEvent = Events()

class ShowEventViewController: UIViewController {

    static let identifier = "ShowEventViewController"
    
    @IBOutlet weak var event: UILabel!
    @IBOutlet weak var eventDesc: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Descrição"
        view.backgroundColor = AppCongifuration.lightGrey()
        navigationController?.setNavigationBarHidden(false, animated: true)
        loadData()
    }
    
    fileprivate func loadData() {
        event.text = showEvent.name
        eventDesc.text = showEvent.eventDescription
        startDate.text = showEvent.startDate
        endDate.text = showEvent.endDate
        adress.text = showEvent.local
        city.text = showEvent.cidade
        state.text = showEvent.estado
        print(showEvent.image)
        showEvent.image.getDataInBackground { (data, error) in
            if let imgData = UIImage(data: data!) {
                self.eventImage.image = imgData
            }
        }
    }
}
