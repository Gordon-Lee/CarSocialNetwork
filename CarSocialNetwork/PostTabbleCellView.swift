//
//  PostCellView.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 9/11/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Parse

class PostTabbleCellView: UITableViewCell {
    
    static let nibName = "PostCellView"
    static let identifier = "postCell"
    static let rowHeight = 600 as CGFloat
    
    @IBOutlet weak var photoDescription: UITextField!
    @IBOutlet weak var thumbPhoto: UIImageView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var like: UIButton!
    
    var user: PFUser!
    
    override func awakeFromNib() {
        setupTap()
        circleProfilePhoto()
    }
    
    fileprivate func setupTap() {
        likeImage.isHidden = true
        likeImage.alpha = 0.6
        let gesture = UITapGestureRecognizer(target: self, action: #selector(PostTabbleCellView.doubleTap(_:)))
        gesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(gesture)
    }
    
    fileprivate func circleProfilePhoto(){
        thumbPhoto.layer.masksToBounds = false
        thumbPhoto.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        thumbPhoto.layer.cornerRadius = 10.0
        thumbPhoto.layer.masksToBounds = true
    }
    
    func doubleTap(_ sender: AnyObject) {
        likeImage.isHidden = false
        likeImage.alpha = 1.0
        print(user.objectId!)
        UIImageView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseIn, animations: {
            self.likeImage.alpha = 0
            }, completion: { (value:Bool) in
            self.likeImage.isHidden = true
        })
    }
}
