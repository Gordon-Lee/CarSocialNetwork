//
//  PostViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Fusuma
import Parse
import SVProgressHUD

class PostViewController: UIViewController, FusumaDelegate {

    let fus = FusumaViewController()
    private var flag = true
    private var postPhoto: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fus.delegate = self
        postPhoto = Photo()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configView()
        navigationController?.navigationBarHidden = true
        if flag {
            fusumaSetup()
            presentViewController(fus, animated: true, completion: nil)
            flag = false
        } else {
            Queue.Main.queue.delay(1.0, closure: {
                let sb = UIStoryboard(name: "HomePage", bundle: NSBundle.mainBundle())
                let vc = sb.instantiateInitialViewController()
                self.navigationController?.presentViewController(vc!, animated: true, completion: nil)
                self.flag = true
            })
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        
    }
    
    private func configView() {
        view.backgroundColor = AppCongifuration.darkGrey()
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
        SVProgressHUD.setBackgroundColor(AppCongifuration.lightGrey())
        SVProgressHUD.show()
    }
    
//    postPhoto.image = PFFile(data: AdjustPhoto.uploadToPhoto(image, type: .NORMAL))!
//    postPhoto.thumbImage = PFFile(data: AdjustPhoto.uploadToPhoto(image, type: .THUMB))!
    
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