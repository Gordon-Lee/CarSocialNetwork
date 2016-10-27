//
//  SearchTableViewCell.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio on 17/10/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let xibName = "SearchResult"
    static let identifier = "searchCell"
    static let rowHeight = 110 as CGFloat

    @IBOutlet weak var searchIMG: UIImageView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var year: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
