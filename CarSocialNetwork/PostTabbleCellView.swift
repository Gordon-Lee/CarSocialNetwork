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
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

class PostTabbleCellView: UITableViewCell {
    
    static let identifier = "postCell"
    static let nibName = "PostCellView"
    static let rowHeight = 600 as CGFloat
    
    @IBOutlet weak var photoDescription: UITextField!
    @IBOutlet weak var thumbPhoto: UIImageView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var like: UIButton!
    
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
        thumbPhoto.layer.cornerRadius = 60.0
        thumbPhoto.layer.masksToBounds = true
    }
    
    func doubleTap(_ sender: AnyObject) {
        likeImage.isHidden = false
        likeImage.alpha = 1.0
        UIImageView.animate(withDuration: 3.0, delay: 2.0, options: .curveEaseIn, animations: {
            self.likeImage.alpha = 0
            }, completion: { (value:Bool) in
            self.likeImage.isHidden = true
        })
    }
}
