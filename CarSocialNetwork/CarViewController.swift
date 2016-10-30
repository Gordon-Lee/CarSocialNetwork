//
//  CarViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio on 15/10/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Fusuma
import Parse
import SVProgressHUD

enum howView {
    case save, inicial
}

class CarViewController: UIViewController {
    
    static let identifier = "Car"

    //fileprivate weak var brandSelection: BrandSelectionView!
    //fileprivate weak var finishedRegister: FinishedCarRegisterView!
    //fileprivate var viewTo: howView = .inicial
    fileprivate var subviewsFrame: CGRect!
    fileprivate var carToSave = Car() {
        didSet {
            brand.text = carToSave.brand
            model.text = carToSave.model
            year.text = String(carToSave.year)
            carToSave.image.getDataInBackground { (data, error) in
                if let img = UIImage(data: data!) {
                    self.image.image = img
                }
            }
        }
    }
    @IBOutlet weak var brand: UITextField!
    @IBOutlet weak var model: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var image: UIImageView!

    fileprivate var fus = FusumaViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCarData()
        configView()
        fus.delegate = self
        FusumaConfig.defaultCfg()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configView()
    }
}

extension CarViewController {
    
    fileprivate func loadCarData() {
        let query = PFUser.query()
        
        query?.includeKey("car")
        query?.getFirstObjectInBackground(block: { (user, error) in
            if error == nil && user?["car"] != nil {
                self.carToSave = user?["car"] as! Car
            }
        })
    }
    
    fileprivate func configView() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = "Registro Carro"
        UIApplication.shared.statusBarStyle = .default
        view.backgroundColor = AppCongifuration.darkGrey()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.topItem?.leftBarButtonItem?.tintColor = AppCongifuration.blue()
    }
    fileprivate func calculateSubFrame() {
        let viewFrame = view.frame
        let viewOrigin = viewFrame.origin
        let navBarHeight = navigationController?.navigationBar.frame.height
        let newY = viewOrigin.y + navBarHeight!
        let newHeight = viewFrame.height - navBarHeight!
        subviewsFrame = CGRect(x: viewOrigin.x, y: newY, width: viewFrame.width, height: newHeight)
    }
    
    fileprivate func showFusuma() {
        present(fus, animated: true, completion: nil)
    }
    
    fileprivate func dissmisView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        
        SVProgressHUD.show()
        carToSave.saveInBackground { (bool, error) in
            if bool {
                SVProgressHUD.dismiss()
                self.dissmisView()
            }
        }
    }
    
    @IBAction func dismissView(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func fusuma(_ sender: Any) {
        showFusuma()
    }
}

extension CarViewController : FusumaDelegate {
    
    func fusumaImageSelected(_ image: UIImage) {
        print("IMAGE SELECTED CAR")
    }
    
    func fusumaDismissedWithImage(_ image: UIImage) {
        print("Called just after FusumaViewController is dismissed.")
        
        self.image.image = image
        carToSave.owner = PFUser.current()!
        carToSave.thumbImage = PFFile(data: AdjustPhoto.uploadToPhoto(image, type: .thumb))!
        carToSave.image = PFFile(data: AdjustPhoto.uploadToPhoto(image, type: .normal))!
        //loadFinishedRegister()
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        print("Called just after a video has been selected.")
    }
    
    func fusumaCameraRollUnauthorized() {
        print("Camera roll unauthorized")
    }
}

//extension CarViewController: BrandSelectionDelegate {
//    func didTapSelectionPhoto(car: Car) {
//        viewTo = .save
//        carToSave = car
//        showFusuma()
//    }
//}
//
//extension CarViewController: FinishedCarDelegate {
//    func didFinishedCarRegister() {
//        carToSave.saveInBackground()
//        self.dismiss(animated: true, completion: nil)
//    }
//}
