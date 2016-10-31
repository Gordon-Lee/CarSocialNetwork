//
//  LoginViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.

import UIKit
import Parse
import FBSDKCoreKit
import FBSDKLoginKit
import ParseFacebookUtilsV4

protocol LoginViewControllerDelegate: class {
    func didTapCancelButton()
}

class LoginViewController: UIViewController {
    
    fileprivate var subviewsFrame: CGRect!
    fileprivate var newMemberSignUp: NewMemberView!
    
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passWordTxt: UITextField!
    @IBOutlet weak var loginFSBK: FBSDKLoginButton!
    
    fileprivate let permissions = ["public_profile"]
    
    override func viewDidLoad() {
        calculateSubviewsFrame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationBar()
        configView()
        hideKeyboard()
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func login(_ sender: AnyObject) {
        loginWithParse("Marco", password: "mm") //(userNameTxt.text!, password: passWordTxt.text!)
    }
    @IBAction func singUp(_ sender: AnyObject) {
         self.signUpNew()
    }
    
    @IBAction func loginWithFace(_ sender: Any) {
        PFFacebookUtils.facebookLoginManager().loginBehavior = FBSDKLoginBehavior.systemAccount
        
        
        let login = FBSDKLoginManager()
        login.loginBehavior = FBSDKLoginBehavior.systemAccount
        login.logIn(withReadPermissions: ["public_profile", "email"], from: self, handler: {(result, error) in
            print("AAAAAAAAAAAAAA \(result?.token)")
            if error != nil {
                print("Error :  \(error)")
            }
            else if (result?.isCancelled)! {
                self.loginWithParse("Marco", password: "mm")
            }
        })
    }
//
//        PFFacebookUtils.logInInBackground(withReadPermissions: self.permissions) { (user, error) in
//            if user == nil {
//                NSLog("Uh oh. The user cancelled the Facebook login.")
//            } else if user!.isNew { //inserted !
//                NSLog("User signed up and logged in through Facebook!")
//            } else {
//                NSLog("User logged in through Facebook! \(user!.username)")
//            }
//        }
//    }
//        PFFacebookUtils.logInWithPermissions(self.permissions, block: {
//            (user: PFUser?, error: NSError?) in
//            if user == nil {
//                NSLog("Uh oh. The user cancelled the Facebook login.")
//            } else if user!.isNew { //inserted !
//                NSLog("User signed up and logged in through Facebook!")
//            } else {
//                NSLog("User logged in through Facebook! \(user!.username)")
//            }
//        })
//    }
    
}

extension LoginViewController {

    fileprivate func loginWithParse(_ username: String!, password: String!) {
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) -> Void in
            guard user == nil else{
                let sb = UIStoryboard(name: "HomePage", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "homePage")
                self.present(vc, animated: true, completion: nil)
                return
            }
        }
    }
    
    
    //MARK: generic FUNCS
    fileprivate func configView() {
        view.backgroundColor = AppCongifuration.darkGrey()
    }
    
    fileprivate func navigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: AppCongifuration.darkGrey()]
        title = "CarSocial"
    }
    
    fileprivate func calculateSubviewsFrame() {
        let viewFrame = view.frame
        let viewOrigin = viewFrame.origin
        let navBarHeight = navigationController?.navigationBar.frame.height
        let newY = viewOrigin.y + navBarHeight!
        let newHeight = viewFrame.height - navBarHeight!
        subviewsFrame = CGRect(x: viewOrigin.x, y: newY, width: viewFrame.width, height: newHeight)
    }
    
    fileprivate func signUpNew(){
        let nib = Bundle.main.loadNibNamed("NewMember", owner: self, options: nil)
        newMemberSignUp = nib!.first as! NewMemberView
        newMemberSignUp.frame = subviewsFrame
        newMemberSignUp.delegate = self
        view.addSubview(newMemberSignUp)
    }
}

extension LoginViewController: LoginViewControllerDelegate {
    func didTapCancelButton() {
        view.sendSubview(toBack: newMemberSignUp)
        newMemberSignUp.removeFromSuperview()
    }
}
