//
//  PostViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Fusuma

class PostViewController: UIViewController, FusumaDelegate {

    let fus = FusumaViewController()
    private var flag = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fus.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = true
        if flag {
            fusumaSetup()
            presentViewController(fus, animated: true, completion: nil)
            flag = false
        } else {
            let sb = UIStoryboard(name: "HomePage", bundle: NSBundle.mainBundle())
            let vc = sb.instantiateInitialViewController()
            navigationController?.presentViewController(vc!, animated: true, completion: nil)
            flag = true
        }
    }
}

extension PostViewController {
    
    private func fusumaSetup() {
        fusumaCameraTitle = "Camera"
        fusumaCameraRollTitle = "Biblioteca"
        
        fusumaTintColor = AppCongifuration.blue()
        fusumaBaseTintColor = AppCongifuration.lightGrey()
        fusumaBackgroundColor = AppCongifuration.darkGrey()
        
        fusumaAlbumImage = UIImage(named: "photoLibrary2.png")
        fusumaCameraImage = UIImage(named: "camera.png")
        fusumaCheckImage = UIImage(named: "ok.png")
        fusumaCloseImage = UIImage(named: "cancel1.png")
        fusumaFlashOnImage = UIImage(named: "flashOn.png")
        fusumaFlashOffImage = UIImage(named: "flashOff.png")
        fusumaFlipImage = UIImage(named: "refresh.png")
    }
    
    func fusumaImageSelected(image: UIImage) {
        print("Image selected")
    }
    
    func fusumaDismissedWithImage(image: UIImage) {
        print("Called just after FusumaViewController is dismissed.")
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: NSURL) {
        print("Called just after a video has been selected.")
    }
    
    func fusumaCameraRollUnauthorized() {
        print("Camera roll unauthorized")
    }
}
