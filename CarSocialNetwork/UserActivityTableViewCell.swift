//
//  UserActivityTableViewCell.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio on 19/10/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit



class UserActivityTableViewCell: UITableViewCell {
    
    static let nibName = "UserActivity"
    static let identifier = "activityCell"
    
    @IBOutlet weak var actvDescription: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var numberOfLikes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setButtonsImage()
    }
    
    fileprivate func setButtonsImage() {
        like.setImage(UIImage(named: "steeringNofiled"), for: .normal)
        like.setImage(UIImage(named: "steering"), for: .selected)
    }
}
