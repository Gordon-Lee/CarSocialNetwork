//
//  PostCellView.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 9/11/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setRounded() {
        let radius = CGRectGetWidth(self.frame) / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

class PostTabbleCellView: UITableViewCell {
    
    static let identifier = "postCell"
    static let nibName = "PostCellView"
    static let rowHeight = 600 as CGFloat
    
    @IBOutlet weak var thumbPhoto: UIImageView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var like: UIButton!
    
    override func awakeFromNib() {
        inicialSetupImageLike()
        circleProfilePhoto()
        setupTap()
    }
    
    private func setupTap() {
        likeImage.hidden = true
        likeImage.alpha = 0.6
        let gesture = UITapGestureRecognizer(target: self, action: #selector(PostTabbleCellView.doubleTap(_:)))
        gesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(gesture)
    }
    
    internal func doubleTap() {
        self.likeImage?.hidden = false
        UIView.animateWithDuration(10.0, delay: 0.2, options: .CurveEaseIn, animations: {
            
            }) { (success) in
                self.likeImage.alpha = 0.6
                //self.likeImage.hidden = true
        }
    }
    
    private func circleProfilePhoto(){
        thumbPhoto.layer.masksToBounds = false
        thumbPhoto.frame = CGRectMake(10, 10, 100, 100)
        thumbPhoto.layer.cornerRadius = 60.0
        thumbPhoto.layer.masksToBounds = true
        
//        thumbPhoto.layer.masksToBounds = false
//        thumbPhoto.layer.cornerRadius = thumbPhoto.frame.size.width / 2
//        thumbPhoto.clipsToBounds = true
//        thumbPhoto.layer.borderWidth = 3.0
//        thumbPhoto.layer.borderColor = AppCongifuration.darkGrey().CGColor
    }
    
    func inicialSetupImageLike() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(PostTabbleCellView.doubleTap(_:)))
        gesture.numberOfTapsRequired = 2
        postImage.addGestureRecognizer(gesture)
        
        likeImage?.hidden = true
    }
    
    func doubleTap(sender: AnyObject) {
        likeImage.hidden = false
        
        UIView.animateWithDuration(1.0, delay: 1.0, options: .AllowAnimatedContent, animations: {
            self.likeImage.alpha = 0 }, completion: { (value:Bool) in
                self.likeImage.hidden = true
        })
    }
    
}
