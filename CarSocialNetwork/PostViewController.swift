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
    fileprivate var postPhoto: Photo!
    
    fileprivate var howView: howViewToDisplay = .FUSUMA
    fileprivate var subviewsFrame: CGRect!
    
    fileprivate var activity: Activity!
    fileprivate weak var descriptionView: DescritptionView!
    fileprivate weak var homeVC: HomeViewController!
    
    fileprivate var currentId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        calculateSubviewsFrame()
        configView()
        fus.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBarVisibility(false, animated: true)
        print(howView.rawValue)
        switch howView {
        case .FUSUMA:
            fusumaSetup()
            howView = .HOME
            present(fus, animated: true, completion: nil)
            return
        case .DESCRIPTION:
            addDescriptionView()
        default:
            showHomeViewController()
            print("PAU NO HOME")
        }
        print(activity.activityType)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    fileprivate func configView() {
        activity = Activity()
        postPhoto = Photo()
        view.backgroundColor = AppCongifuration.darkGrey()
    }
}
//MARK: Parse
extension PostViewController {
    fileprivate func saveEverything() {
        postPhoto.saveInBackground(){(succeeded, error) in
            if succeeded {
                self.saveActivity(self.postPhoto)
                return
            }
        }
    }
    
    fileprivate func saveActivity(_ photoId: Photo) {
        activity.fromUser = PFUser.current()!
        activity.toUser = PFUser.current()!
        activity.image = photoId
        activity.activityType = ActivityType.post.rawValue
        activity.saveInBackground()
    }
}
//MARK: FUSUMA
extension PostViewController: FusumaDelegate {
    
    fileprivate func fusumaSetup() {
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
    
    func fusumaImageSelected(_ image: UIImage) {
        print("IMAGE SELECTED")
        howView = .DESCRIPTION
        savePost(image)
    }
    
    func fusumaDismissedWithImage(_ image: UIImage) {
        print("Called just after FusumaViewController is dismissed.")
        addDescriptionView()
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        print("Called just after a video has been selected.")
    }
    
    func fusumaCameraRollUnauthorized() {
        print("Camera roll unauthorized")
    }
}
//MARK: DELEGATES
extension PostViewController: DescriptionViewDelegate {
    fileprivate func calculateSubviewsFrame() {
        let viewFrame = view.frame
        let viewOrigin = viewFrame.origin
        let navBarHeight = navigationController?.navigationBar.frame.height
        let newY = viewOrigin.y + navBarHeight!
        let newHeight = viewFrame.height - navBarHeight!
        subviewsFrame = CGRect(x: viewOrigin.x, y: newY, width: viewFrame.width, height: newHeight)
    }
    
    fileprivate func addDescriptionView() {
        let nib = Bundle.main.loadNibNamed("DescriptionPost", owner: self, options: nil)
        descriptionView = nib!.first as! DescritptionView
        descriptionView.delegate = self
        descriptionView.frame = subviewsFrame
        view.addSubview(descriptionView)
    }
    
    func didClickToFinish(_ comment: String) {
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
    fileprivate func showHomeViewController() {
        let sb = UIStoryboard(name: "HomePage", bundle: Bundle.main)
        let vc = sb.instantiateInitialViewController()
        navigationController?.present(vc!, animated: true, completion: nil)
    }
    
    fileprivate func savePost(_ image: UIImage) {
        postPhoto.owner = PFUser.current()!
        postPhoto.thumbImage = PFFile(data: AdjustPhoto.uploadToPhoto(image, type: .thumb))!
        postPhoto.image = PFFile(data: AdjustPhoto.uploadToPhoto(image, type: .normal))!
    }
}
