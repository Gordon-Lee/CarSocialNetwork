//
//  EditViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Fusuma

class EditViewController: UIViewController {
    
    static let identifier = "EditProfile"
    
    fileprivate var fusuma: FusumaViewController!

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    fileprivate func configView() {
        UIApplication.shared.statusBarStyle = .default
        view.backgroundColor = AppCongifuration.lightGrey()
        
        navigationController?.navigationBar.barTintColor = AppCongifuration.lightGrey()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}

extension EditViewController {
    @IBAction func dismissView(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func fusumaCamera(_ sender: AnyObject) {
        fusuma = FusumaViewController()
        fusuma.delegate = self
        present(fusuma, animated: true, completion: nil)
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
