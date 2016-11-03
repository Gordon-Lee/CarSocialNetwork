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
    
    var delegate : LoginViewControllerDelegate!
    
    override func awakeFromNib() {
        configView()
    }
    
    fileprivate func navigationBarConfig() {
        
    }
    
    fileprivate func configView() {
        self.backgroundColor = AppCongifuration.darkGrey()
    }
    
    @IBAction func signUpCarSocial(_ sender: AnyObject) {
        let user = PFUser()

        user.username = username.text!
        user.password = password.text!
        user.email = email.text!
        
        SVProgressHUD.show()
        
        user.signUpInBackground { (sucess, error) in
            guard error == nil else {
                //SVProgressHUD.show(withStatus: error?.description)
                UserDefaults.sharedInstance.Save(self.username.text!, password: self.password.text!, loginType: .normal)
                self.delegate.didTapSignup()
                SVProgressHUD.dismiss()
                return
            }
            SVProgressHUD.dismiss()
        }
    }
    
    
    @IBAction func cancelar(_ sender: AnyObject) {
        delegate?.didTapCancelButton()
    }    
    @IBAction func recoveryPassword(_ sender: AnyObject) {
        
        
        
        delegate?.didTapRecoverAccount()
        
//        var alert = UIAlertController(title: nil, message: "Your password has been sent to your email address.", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        //self.presentViewController(alert, animated: true, completion: nil)
        
    }
}
