//
//  NewMemberUIView.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 9/1/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD


class NewMemberView: UIView {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    override func awakeFromNib() {
        configView()
    }
    
    private func navigationBarConfig() {
        
    }
    
    private func configView() {
        self.backgroundColor = AppCongifuration.darkGrey()
    }
    
    @IBAction func signUpCarSocial(sender: AnyObject) {
        let user = PFUser()

        user.username = username.text!
        user.password = password.text!
        user.email = email.text!
        
        SVProgressHUD.show()
        
        user.signUpInBackgroundWithBlock { (sucess, error) in
            guard error == nil else {
                SVProgressHUD.showWithStatus(error?.description)
                SVProgressHUD.dismiss()
                return
            }
            SVProgressHUD.dismiss()
        }
    }
}
