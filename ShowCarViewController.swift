//
//  ShowCarViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio on 03/11/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD

var showCar = Car()

class ShowCarViewController: UIViewController {
    
    static let identifier = "ShowCarViewController"
    
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var onwerImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        loadData()
        view.backgroundColor = AppCongifuration.lightGrey()
        title = "Carro"
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    fileprivate func loadData() {
        userName.text = showCar.owner.username
        model.text = showCar.model
        brand.text = showCar.brand
        year.text = "\(showCar.year)"
        
        showCar.image.getDataInBackground { (data, error) in
            if let imgData = UIImage(data: data!) {
                self.carImage.image = imgData
            }
        }
        let imageToShow = showCar.owner["profileImage"] as! PFFile
        imageToShow.getDataInBackground { (data, error) in
            if let imgData = UIImage(data: data!) {
                self.onwerImage.image = imgData
                SVProgressHUD.dismiss()
            }
        }
    }
}
