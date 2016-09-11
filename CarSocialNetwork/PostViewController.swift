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
            self.navigationController?.presentViewController(vc!, animated: true, completion: nil)
            flag = true
        }
    }
}

//public var fusumaAlbumImage : UIImage? = nil
//public var fusumaCameraImage : UIImage? = nil
//public var fusumaVideoImage : UIImage? = nil
//public var fusumaCheckImage : UIImage? = nil
//public var fusumaCloseImage : UIImage? = nil
//public var fusumaFlashOnImage : UIImage? = nil
//public var fusumaFlashOffImage : UIImage? = nil
//public var fusumaFlipImage : UIImage? = nil
//public var fusumaShotImage : UIImage? = nil

extension PostViewController {
    
    private func fusumaSetup() {
        fusumaTintColor = AppCongifuration.blue()
        
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
