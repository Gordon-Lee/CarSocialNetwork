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
        setupTap()
        circleProfilePhoto()
    }
    
    private func setupTap() {
        likeImage.hidden = true
        likeImage.alpha = 0.6
        let gesture = UITapGestureRecognizer(target: self, action: #selector(PostTabbleCellView.doubleTap(_:)))
        gesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(gesture)
    }
    
    private func circleProfilePhoto(){
        thumbPhoto.layer.masksToBounds = false
        thumbPhoto.frame = CGRectMake(10, 10, 100, 100)
        thumbPhoto.layer.cornerRadius = 60.0
        thumbPhoto.layer.masksToBounds = true
    }
    
    func doubleTap(sender: AnyObject) {
        likeImage.hidden = false
        likeImage.alpha = 1.0
        UIImageView.animateWithDuration(3.0, delay: 2.0, options: .CurveEaseIn, animations: {
            self.likeImage.alpha = 0
            }, completion: { (value:Bool) in
            self.likeImage.hidden = true
        })
    }
}
