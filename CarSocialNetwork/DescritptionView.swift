//
//  DescritptionView.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 25/09/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol DescriptionViewDelegate: class {
    func didClickToFinish(_ comment: String)
    func didTapCancel()
}

class DescritptionView: UIView {

    @IBOutlet weak var userDescription: UITextField!
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var commenBox: UITextField!
    
    weak var delegate: DescriptionViewDelegate!
    
    static let nibName = "DescriptionPost"
    
    override func awakeFromNib() {
        backgroundColor = AppCongifuration.darkGrey()
        SVProgressHUD.dismiss()
    }
    
    @IBAction func trashPost(_ sender: AnyObject) {
        print("POST PHOTO")
        delegate?.didTapCancel()
    }
    
    @IBAction func postPhoto(_ sender: AnyObject) {
        print("POST PHOTO "+commenBox.text!)
        delegate?.didClickToFinish(commenBox.text!)
    }
}
