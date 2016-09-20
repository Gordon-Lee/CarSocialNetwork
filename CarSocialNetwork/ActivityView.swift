//
//  ActivityView.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 9/20/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit

class ActivityView: UITableViewCell {
    
    static let identifier = "activityCell"
    static let nibName = "Activity"
    static let rowHeight = 150 as CGFloat
    
    @IBOutlet weak var thumbProfile: UIImageView!
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var activityDescription: UILabel!
    
    override func awakeFromNib() {
        
    }
}
