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
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var onwerImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        loadData()
        onwerImage.setCircle()
        view.backgroundColor = AppCongifuration.lightGrey()
        title = "Carro"
        navigationController?.setNavigationBarHidden(false, animated: true)
        setupTap()
    }
    
    fileprivate func setupTap() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ShowCarViewController.showProfileDetails))
        gesture.numberOfTapsRequired = 1
        //gesture.delegate = self
        onwerImage.isUserInteractionEnabled = true
        onwerImage.addGestureRecognizer(gesture)
    }
    
    @objc fileprivate func showProfileDetails() {
        let vc = storyboard?.instantiateViewController(withIdentifier: ShowProfileViewController.identifier)
        userShow.objId = showCar.owner.objectId
        userShow.userName = showCar.owner.username
        userShow.profilePhoto = showCar.owner["profileImage"] as? PFFile
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    fileprivate func loadData() {
        userName.text = showCar.owner.username
        model.text = showCar.model
        brand.text = showCar.brand
        year.text = "\(showCar.year)"
        
        showCar.image.getDataInBackground { (data, error) in
            if let imgData = UIImage(data: data!) {
                self.image.image = imgData
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
