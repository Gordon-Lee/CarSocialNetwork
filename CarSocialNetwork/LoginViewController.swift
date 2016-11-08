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
import FBSDKShareKit
import ParseFacebookUtilsV4

protocol LoginViewControllerDelegate: class {
    func didTapCancelButton()
    func didTapSignup()
    func didTapRecoverAccount()
}

class LoginViewController: UIViewController {
    
    fileprivate var subviewsFrame: CGRect!
    fileprivate var newMemberSignUp: NewMemberView!
    
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passWordTxt: UITextField!
    @IBOutlet weak var loginFSBK: FBSDKLoginButton!
    var dict : [String : AnyObject]!
    
    override func viewDidLoad() {
        calculateSubviewsFrame()
//        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow),
//                                               name: NSNotification.Name.UIKeyboardWillShow,
//                                               object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide),
//                                               name: NSNotification.Name.UIKeyboardWillHide,
//                                               object: nil)
//    
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
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= 50.0
        
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y == 0{
//                self.view.frame.origin.y -= (keyboardSize.height - 60.0)
//            }
//        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += 50.0
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y != 0{
//                self.view.frame.origin.y += (keyboardSize.height - 60.0)
//            }
//        }
    }
    
    @IBAction func login(_ sender: AnyObject) {
        loginWithParse("Marco", password: "12345")
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
            print("FACE login complete")
            print("\(FBSDKAccessToken.current().userID)")
            //print("\(FBSDKAccessToken.current().)")
            getFBUserData()
            //self.homeView()
        } else {
            print(error.localizedDescription)
        }
    }
    
        func getFBUserData(){
            if((FBSDKAccessToken.current()) != nil){
                FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                    if (error == nil){
                        self.dict = result as! [String : AnyObject]
                        print(result!)
                        print(self.dict)
                    }
                })
            }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logout")
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
    func didTapRecoverAccount() {
    
        let alert = UIAlertController(title: "Recuperar", message: "Digite o seu email cadastrado para solicitar o reset da senha", preferredStyle: .alert)
    
        alert.addTextField { (textField) in }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            let textField = alert.textFields![0]
            //PFUser.requestPasswordResetForEmail(inBackground: textField.text!)
            PFUser.requestPasswordResetForEmail(inBackground: textField.text!, block: { (success, error) in
                if success {
                    self.showEmailOK()
                }else {
                    self.showErroEmail()
                }
            })
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func showErroEmail() {
        
        let alert = UIAlertController(title: "Erro", message: "Email digitado errado", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func showEmailOK() {
        
        let alert = UIAlertController(title: "Verificação - OK", message: "Vá a sua caixa de email.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
