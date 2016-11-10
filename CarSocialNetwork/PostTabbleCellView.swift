//
//  PostCellView.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 9/11/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Parse

protocol PostTableViewDelegate: class {
    func didTapProfile()
    func likePhoto()
}

class PostTabbleCellView: UITableViewCell {
    
    static let nibName = "PostCellView"
    static let identifier = "postCell"
    static let rowHeight = 625 as CGFloat
    
    
    @IBOutlet weak var postDescription: UILabel!
    @IBOutlet weak var thumbPhoto: UIImageView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var like: UIButton!
    
    var delegate: PostTableViewDelegate!
    
    override func awakeFromNib() {
        setupTap()
        setButtonsImage()
    }
    
    fileprivate func setupTap() {
        likeImage.isHidden = true
        likeImage.alpha = 0.6
        let gesture = UITapGestureRecognizer(target: self, action: #selector(PostTabbleCellView.doubleTap(_:)))
        gesture.numberOfTapsRequired = 2
        gesture.delegate = self
        postImage.isUserInteractionEnabled = true
        postImage.addGestureRecognizer(gesture)
    }
    
    fileprivate func setButtonsImage() {
        thumbPhoto.setCircle()
        like.setImage(UIImage(named: "steeringNofiled"), for: .normal)
        like.setImage(UIImage(named: "steering"), for: .selected)
    }
    
    func doubleTap(_ sender: UITapGestureRecognizer? = nil) {
        likeImage.isHidden = false
        likeImage.alpha = 1.0
        likeImage.alpha = 0.8
        UIImageView.animate(withDuration: 1.5, delay: 0, options: .curveEaseIn, animations: {
            self.likeImage.alpha = 0
            self.likeImage.alpha = 1.0
            }, completion: { (value:Bool) in
            self.likeImage.isHidden = true
            if !self.like.isSelected {
                self.like.isSelected = true
                self.delegate?.likePhoto()
            }
        })
    }
}
