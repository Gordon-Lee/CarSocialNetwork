//
//  PostViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Fusuma

//extension FusumaViewController {
//    public override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(true)
//          }
//}

class PostViewController: UIViewController, FusumaDelegate {

    let fusuma = FusumaViewController()
    private var flag = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fusuma.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = true
        if flag {
            presentViewController(fusuma, animated: true, completion: nil)
            flag = false
        }else {
            let sb = UIStoryboard(name: "HomePage", bundle: NSBundle.mainBundle())
            let vc = sb.instantiateInitialViewController()
            self.navigationController?.presentViewController(vc!, animated: true, completion: nil)
            flag = true
        }
        
    }
}

extension PostViewController {
    
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
