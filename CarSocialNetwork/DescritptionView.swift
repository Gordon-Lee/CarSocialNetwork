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
    func didClickToFinish(_ comment: String, image: UIImage)
    func didTapCancel()
}

class DescritptionView: UIView {

    @IBOutlet weak var userDescription: UITextField!
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var commenBox: UITextField!
    
    weak var delegate: DescriptionViewDelegate!
    
    static let nibName = "DescriptionPost"
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        endEditing(true)
    }
    
    override func awakeFromNib() {
        backgroundColor = AppCongifuration.darkGrey()
        thumbImage?.image = photo
        SVProgressHUD.dismiss()
    }
    
    @IBAction func trashPost(_ sender: AnyObject) {
        delegate?.didTapCancel()
    }
    
    @IBAction func postPhoto(_ sender: AnyObject) {
        HomeViewController.reloadData = true
        delegate?.didClickToFinish(commenBox.text!, image: photo)
    }
    
}
