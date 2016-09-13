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
            Queue.Main.queue.delay(3, closure: { 
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
        postPhoto.image = PFFile(data: uploadPhoto(image))!
        postPhoto.thumbImage = PFFile(data: thumbImage(image))!
        save()
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

extension PostViewController {
    
    private func save() {
        postPhoto.owner = PFUser.currentUser()!
        postPhoto.saveInBackground()
//        postPhoto.saveInBackgroundWithBlock { (success, error) in
//            if success {
//                SVProgressHUD.dismiss()
//            } else {
//                SVProgressHUD.showErrorWithStatus(error?.localizedDescription)
//            }
//        }
    }
    
    private func uploadPhoto(image: UIImage) -> NSData {
        //TODOOOOOO
        var newSize: CGSize
        let size = image.size
        
        let widthRatio  = postPhoto.targetImage.width  / image.size.width
        let heightRatio = postPhoto.targetImage.height / image.size.height
        
            if(widthRatio > heightRatio) {
                newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
            } else {
                newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
            }
        
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let upImage = UIImagePNGRepresentation(newImage)
        
        return upImage!
    }
    
    private func thumbImage(image: UIImage) -> NSData {
        var newSize: CGSize
        let size = image.size
        
        let widthRatio  = postPhoto.thumbTargetImage.width  / image.size.width
        let heightRatio = postPhoto.thumbTargetImage.height / image.size.height
        
            if(widthRatio > heightRatio) {
                newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
            } else {
                newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
            }
        
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let upImage = UIImagePNGRepresentation(newImage)
        
        return upImage!
    }
}
