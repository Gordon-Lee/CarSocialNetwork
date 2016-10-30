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

class EditViewController: UIViewController {
    
    static let identifier = "EditProfile"
    
    fileprivate var fusuma: FusumaViewController!

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var TopLabel: UILabel!
    @IBOutlet weak var middleLabel: UILabel!
    
    fileprivate var usr: Usr! {
        didSet {
            
            usr.thumbImage?.getDataInBackground(block: { (data, error) in
                if let image = UIImage(data: data!) {
                    self.userImage.image = image
                    print("ASDASDASDASDASSDADADSASDADA \(self.usr.userName!)")
                    self.TopLabel.text = self.usr.userName
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsrData()
        configView()
        saveButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.topItem?.title = "Editar"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
}

extension EditViewController {
    
    fileprivate func loadUsrData() {
        let queryUser = PFUser.query()
        queryUser?.getFirstObjectInBackground(block: { (user, error) in
            if error == nil {
                let u = user as! PFUser
                self.usr = Usr(obejctId: u.objectId!,
                               username: u.username,
                               email: u.email,
                               thumbImage: user?["thumbImage"] as! PFFile?,
                               photo: user?["profileImage"] as! PFFile?)
                return
            }
        })
    }
    
    fileprivate func configView() {
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
        fusuma = FusumaViewController()
        fusuma.delegate = self
        present(fusuma, animated: true, completion: nil)
    }
    @IBAction func saveEdit(_ sender: Any) {
        
        if let cuser = PFUser.current() {
            cuser["profileImage"] =  PFFile(data: AdjustPhoto.uploadToPhoto(userImage.image!, type: .normal))!
            cuser["thumbImage"] = PFFile(data: AdjustPhoto.uploadToPhoto(userImage.image!, type: .thumb))!
            
            cuser.saveInBackground(block: { (bool, error) in
                if bool {
                    self.dissmissView()
                }
            })
        }
        
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
