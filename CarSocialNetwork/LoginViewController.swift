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
        
        if(FBSDKAccessToken.current() == nil)
        {
            print("not logged in")
        }
        else{
            print("logged in already")
        }
        
        loginFSBK.readPermissions = ["public_profile","email"]
        loginFSBK.delegate = self
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
        loginWithParse(userNameTxt.text!, password: passWordTxt.text!) //(userNameTxt.text!, password: passWordTxt.text!)
    }
    @IBAction func singUp(_ sender: AnyObject) {
         self.signUpNew()
    }
    
    @IBAction func loginWithFace(_ sender: Any) {
//        PFFacebookUtils.facebookLoginManager().loginBehavior = FBSDKLoginBehavior.systemAccount
//        print("FACEEEEEEEE")
//        let login = FBSDKLoginManager()
//        
//        login.loginBehavior = FBSDKLoginBehavior.systemAccount
//        login.logIn(withReadPermissions: ["public_profile", "email"], from: self, handler: {(result, error) in
//            print("AAAAAAAAAAAAAA \(result?.token)")
//            if error != nil {
//                print("Error :  \(error)")
//            }
//            if !(result?.isCancelled)! {
//                self.loginWithParse("Marco", password: "mm")
//            }
//        })
    }
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
        self.loginFSBK.readPermissions = ["public_profile", "email"]
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

extension LoginViewController: FBSDKLoginButtonDelegate {
    //MARK -FB login
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        //logged in
        if(error == nil)
        {
            print("login complete")
            print(result.grantedPermissions)
        }
        else{
            print(error.localizedDescription)
        }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //logout
        print("logout")
    }
}


extension LoginViewController: LoginViewControllerDelegate {
    func didTapCancelButton() {
        view.sendSubview(toBack: newMemberSignUp)
        newMemberSignUp.removeFromSuperview()
    }
}
