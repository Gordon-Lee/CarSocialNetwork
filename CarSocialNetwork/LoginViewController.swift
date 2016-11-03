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
    func didTapSignup()
}

class LoginViewController: UIViewController {
    
    fileprivate var subviewsFrame: CGRect!
    fileprivate var newMemberSignUp: NewMemberView!
    
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passWordTxt: UITextField!
    @IBOutlet weak var loginFSBK: FBSDKLoginButton!
    
    override func viewDidLoad() {
        calculateSubviewsFrame()
    
        if FBSDKAccessToken.current() != nil {
            print(FBSDKAccessToken.current().userID!)
            //getUserData()
            //returnUserProfileImage(accessToken: FBSDKAccessToken.current().userID! as NSString)
            //self.homeView()
        }
        
        loginFSBK.readPermissions = ["public_profile","email"]
        loginFSBK.delegate = self
    }
    
    func returnUserProfileImage(accessToken: NSString)
    {
        let userID = accessToken
        let facebookProfileUrl = NSURL(string: "http://graph.facebook.com/\(userID)/picture?type=large")
        
        if let data = NSData(contentsOf: facebookProfileUrl as! URL) {
            let image = UIImage(data: data as Data)
            print("USER FOtO \(image)")
        }
        
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
                self.homeView()
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
    
    fileprivate func homeView() {
        let sb = UIStoryboard(name: HomeViewController.storyIndentifier, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "homePage")
        self.present(vc, animated: true, completion: nil)
    }
}

extension LoginViewController: FBSDKLoginButtonDelegate {
    //MARK -FB login
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error == nil {
            print("login complete")
            
            self.homeView()
        }
        else{
            print(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logout")
    }
    
    fileprivate func getUserData() {
        let accessToken = FBSDKAccessToken.current().userID
        let url = NSURL(string: "https://graph.facebook.com/me/picture?type=large&return_ssl_resources=1&access_token=\(accessToken)")
        
        let urlRequest = NSURLRequest(url: url! as URL)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest as URLRequest, queue: OperationQueue.main, completionHandler: {
            response, data, error in
            
            //let fbImageData = data
            let image = UIImage(data: data!)
            print("MMMAAAGE +\(image)")
        })
    }
}
    



extension LoginViewController: LoginViewControllerDelegate {
    func didTapCancelButton() {
        view.sendSubview(toBack: newMemberSignUp)
        newMemberSignUp.removeFromSuperview()
    }
    func didTapSignup() {
        homeView()
    }
}
