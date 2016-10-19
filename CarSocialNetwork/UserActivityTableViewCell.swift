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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
