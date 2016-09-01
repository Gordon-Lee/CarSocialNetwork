//
//  LoginViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passWordTxt: UITextField!
    
    var navigationControllers: UINavigationController?
    
    override func viewDidLoad() {
        navigationControllers?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: AppColor.black()]
        navigationControllers?.navigationBar.hidden = false
        title = "Aeee"
        navigationControllers?.navigationBar.tintColor = AppColor.blue()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func login(sender: AnyObject) {
        loginWithParse(userNameTxt.text!, password: passWordTxt.text!)
    
    }
}

extension LoginViewController {
    private func loginWithParse(username: String!, password: String!) {
        
        
        PFUser.logInWithUsernameInBackground(username, password: password) { (user, error) -> Void in
            guard user == nil else{
                print(username+" || "+password)
                let sb = UIStoryboard(name: "HomePage", bundle: nil)
                let vc = sb.instantiateViewControllerWithIdentifier("homePage")
                self.presentViewController(vc, animated: true, completion: nil)
                return
            }
        }
    }
}