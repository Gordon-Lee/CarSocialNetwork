//
//  LoginViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    private var subviewsFrame: CGRect!
    private var newMemberSignUp: NewMemberView!
    
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passWordTxt: UITextField!
    
    override func viewDidLoad() {
        calculateSubviewsFrame()
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationBar()
        configView()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: generic FUNCS
    private func configView() {
        view.backgroundColor = AppCongifuration.darkGrey()
    }

    private func navigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: AppCongifuration.lightGrey()]
        title = "CarSocial"
    }
    
    private func calculateSubviewsFrame() {
        let viewFrame = view.frame
        let viewOrigin = viewFrame.origin
        let navBarHeight = navigationController?.navigationBar.frame.height
        let newY = viewOrigin.y + navBarHeight!
        let newHeight = viewFrame.height - navBarHeight!
        subviewsFrame = CGRect(x: viewOrigin.x, y: newY, width: viewFrame.width, height: newHeight)
    }
    
    private func signUpNew(){
        let nib = NSBundle.mainBundle().loadNibNamed("NewMember", owner: self, options: nil)
        newMemberSignUp = nib.first as! NewMemberView
        newMemberSignUp.frame = subviewsFrame
        view.addSubview(newMemberSignUp)
    }
    
    @IBAction func login(sender: AnyObject) {
        loginWithParse(userNameTxt.text!, password: passWordTxt.text!)
    }
    @IBAction func singUp(sender: AnyObject) {
         self.signUpNew()
    }
    
    
}

extension LoginViewController {
    private func loginWithParse(username: String!, password: String!) {
        PFUser.logInWithUsernameInBackground(username, password: password) { (user, error) -> Void in
            guard user == nil else{
                let sb = UIStoryboard(name: "HomePage", bundle: nil)
                let vc = sb.instantiateViewControllerWithIdentifier("homePage")
                self.presentViewController(vc, animated: true, completion: nil)
                return
            }
        }
    }
}