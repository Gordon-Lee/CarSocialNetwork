//
//  EditViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Fusuma
import Parse
import SVProgressHUD

class EditViewController: UIViewController {
    
    static let identifier = "EditProfile"
    
    fileprivate var fusuma: FusumaViewController!

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var TopLabel: UILabel!
    @IBOutlet weak var middleLabel: UILabel!
    
    fileprivate var usr: Usr!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        saveButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        loadUsrData()
        
        navigationController?.navigationBar.topItem?.title = "Editar"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
}

extension EditViewController {
    
    fileprivate func loadUsrData() {
        self.TopLabel.text = PFUser.current()?.username
        self.middleLabel.text = PFUser.current()?.email
        if PFUser.current()?["profileImage"] != nil {
            let img = PFUser.current()?["profileImage"] as! PFFile
            img.getDataInBackground(block: { (data, error) in
                if let imgData = UIImage(data: data!) {
                    self.userImage.image = imgData
                }
            })
        }

    }
    
    fileprivate func configView() {
        fusuma = FusumaViewController()
        FusumaConfig.defaultCfg()
        fusuma.delegate = self
        UIApplication.shared.statusBarStyle = .default
        view.backgroundColor = AppCongifuration.lightGrey()
        
        navigationController?.navigationBar.barTintColor = AppCongifuration.lightGrey()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    fileprivate func dissmissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //IBAC
    @IBAction func dismissView(_ sender: AnyObject) {
        dissmissView()
    }
    @IBAction func fusumaCamera(_ sender: AnyObject) {
        //fusuma = FusumaViewController()
        
        present(fusuma, animated: true, completion: nil)
    }
    @IBAction func saveEdit(_ sender: Any) {
        
        SVProgressHUD.show()
        PFUser.current()?["profileImage"] = PFFile(data: AdjustPhoto.uploadToPhoto(userImage.image!, type: .normal))!
        PFUser.current()?["thumbImage"] = PFFile(data: AdjustPhoto.uploadToPhoto(userImage.image!, type: .thumb))!
        
        PFUser.current()?.saveInBackground(block: { (bool, error) in
            if bool {
                SVProgressHUD.dismiss()
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
}

extension EditViewController: FusumaDelegate {
    func fusumaImageSelected(_ image: UIImage) {
        print("IMAGE SELECTED POST")
        
    }
    
    func fusumaDismissedWithImage(_ image: UIImage) {
        print("Called just after FusumaViewController is dismissed.")
        userImage.image = image
        saveButton.isEnabled = true
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        print("Called just after a video has been selected.")
    }
    
    func fusumaCameraRollUnauthorized() {
        print("Camera roll unauthorized")
    }
}
