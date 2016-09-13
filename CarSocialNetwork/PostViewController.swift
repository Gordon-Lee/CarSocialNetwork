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
class PostViewController: UIViewController, FusumaDelegate {

    let fus = FusumaViewController()
    private var flag = true
    private var postPhoto = Photo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fus.delegate = self
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
            let sb = UIStoryboard(name: "HomePage", bundle: NSBundle.mainBundle())
            let vc = sb.instantiateInitialViewController()
            navigationController?.presentViewController(vc!, animated: true, completion: nil)
            flag = true
        }
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
        uploadPhoto(image)
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
    
    private func uploadPhoto(image: UIImage) {
        //TODOOOOOO
//        let size = image.size
//        
//        let widthRatio  = postPhoto.targetImage.width  / image.size.width
//        let heightRatio = postPhoto.targetImage.height / image.size.height
//        
//        // Figure out what our orientation is, and use that to form the rectangle
//        var newSize: CGSize
//        if(widthRatio > heightRatio) {
//            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
//        } else {
//            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
//        }
//        
//        // This is the rect that we've calculated out and this is what is actually used below
//        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
//        
//        // Actually do the resizing to the rect using the ImageContext stuff
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
//        image.drawInRect(rect)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        let upImage = UIImagePNGRepresentation(newImage)
//        
//        postPhoto.image = PFFile(data: upImage!)!
//        
//        postPhoto.saveInBackground()
    }
}
