//
//  PostCellView.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 9/11/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit

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
