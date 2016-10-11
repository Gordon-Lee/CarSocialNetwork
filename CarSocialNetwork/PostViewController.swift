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

enum howViewToDisplay: String {
    case FUSUMA, HOME, DESCRIPTION
}

class PostViewController: UIViewController {

    let fus = FusumaViewController()
    private var postPhoto: Photo!
    
    private var howView: howViewToDisplay = .FUSUMA
    private var subviewsFrame: CGRect!
    
    private var activity: Activity!
    private weak var descriptionView: DescritptionView!
    private weak var homeVC: HomeViewController!
    
    private var currentId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = false
        calculateSubviewsFrame()
        configView()
        fus.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBarVisibility(false, animated: true)
        print(howView.rawValue)
        switch howView {
        case .FUSUMA:
            fusumaSetup()
            howView = .HOME
            presentViewController(fus, animated: true, completion: nil)
            return
        case .DESCRIPTION:
            addDescriptionView()
        default:
            showHomeViewController()
            print("PAU NO HOME")
        }
        print(activity.activityType)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    private func configView() {
        activity = Activity()
        postPhoto = Photo()
        view.backgroundColor = AppCongifuration.darkGrey()
    }
}
//MARK: Parse
extension PostViewController {
    private func saveEverything() {
        postPhoto.saveInBackgroundWithBlock(){(succeeded, error) in
            if succeeded {
                self.saveActivity(self.postPhoto)
                return
            }
        }
    }
    
    private func saveActivity(photoId: Photo) {
        activity.fromUser = PFUser.currentUser()!
        activity.toUser = PFUser.currentUser()!
        activity.image = photoId
        activity.activityType = ActivityType.POST.rawValue
        activity.saveInBackground()
    }
}
//MARK: FUSUMA
extension PostViewController: FusumaDelegate {
    
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
        print("IMAGE SELECTED")
        howView = .DESCRIPTION
        savePost(image)
    }
    
    func fusumaDismissedWithImage(image: UIImage) {
        print("Called just after FusumaViewController is dismissed.")
        addDescriptionView()
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: NSURL) {
        print("Called just after a video has been selected.")
    }
    
    func fusumaCameraRollUnauthorized() {
        print("Camera roll unauthorized")
    }
}
//MARK: DELEGATES
extension PostViewController: DescriptionViewDelegate {
    private func calculateSubviewsFrame() {
        let viewFrame = view.frame
        let viewOrigin = viewFrame.origin
        let navBarHeight = navigationController?.navigationBar.frame.height
        let newY = viewOrigin.y + navBarHeight!
        let newHeight = viewFrame.height - navBarHeight!
        subviewsFrame = CGRect(x: viewOrigin.x, y: newY, width: viewFrame.width, height: newHeight)
    }
    
    private func addDescriptionView() {
        let nib = NSBundle.mainBundle().loadNibNamed("DescriptionPost", owner: self, options: nil)
        descriptionView = nib.first as! DescritptionView
        descriptionView.delegate = self
        descriptionView.frame = subviewsFrame
        view.addSubview(descriptionView)
    }
    
    func didClickToFinish(comment: String) {
        activity.content = comment as String
        saveEverything()
        showHomeViewController()
    }
    
    func didTapCancel() {
        showHomeViewController()
    }
}
//MARK: Generic
extension PostViewController {
    private func showHomeViewController() {
        let sb = UIStoryboard(name: "HomePage", bundle: NSBundle.mainBundle())
        let vc = sb.instantiateInitialViewController()
        navigationController?.presentViewController(vc!, animated: true, completion: nil)
    }
    
    private func savePost(image: UIImage) {
        postPhoto.owner = PFUser.currentUser()!
        postPhoto.thumbImage = PFFile(data: AdjustPhoto.uploadToPhoto(image, type: .THUMB))!
        postPhoto.image = PFFile(data: AdjustPhoto.uploadToPhoto(image, type: .NORMAL))!
    }
}
