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
    
        loginFSBK.readPermissions = ["public_profile","email"]
        loginFSBK.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loginFSBK.isHidden = true
        navigationBar()
        configView()
        hideKeyboard()
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= 50.0
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= (keyboardSize.height - 60.0)
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += 50.0
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += (keyboardSize.height - 60.0)
            }
        }
    }
    
    @IBAction func login(_ sender: AnyObject) {
        loginWithParse(userNameTxt.text!, password: passWordTxt.text!)
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
                UserDefaults.sharedInstance.Save(username: self.userNameTxt.text!, password: self.passWordTxt.text!, loginType: .normal)
                return
            }
            
            if error != nil {
                self.showErroEmail(message: "Usuáriou e/ou senha errados!")
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
//FABEBUG
extension LoginViewController: FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error == nil {
            print("FACE login complete")
            print("\(FBSDKAccessToken.current().userID)")
//            getFBUserData()
            returnUserProfileImage()
            downloadImage(url: URL(string: "http://graph.facebook.com/\(FBSDKAccessToken.current()!.userID!)/picture?type=large")!)
            //self.homeView()
        } else {
            print(error.localizedDescription)
        }
    }
    
    func getFBUserData() {
            let imgURLString = "http://graph.facebook.com/\(FBSDKAccessToken.current()!.userID!)/picture?type=large" //type=normal
            print(imgURLString)
            let imgURL = NSURL(string: imgURLString)
            let imageData = NSData(contentsOf: imgURL! as URL)
            let image = UIImage(data: imageData! as Data)
            print("IMAGE \(image)")
        
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logout")
    }
    
    func returnUserProfileImage() {
        
        let facebookProfileUrl = NSURL(string: "http://graph.facebook.com/\(FBSDKAccessToken.current()!.userID!)/picture?type=large")
        
        if let data = NSData(contentsOf: facebookProfileUrl as! URL) {
            let image = UIImage(data: data as Data)
            print("USER FOtO \(image)")
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                //self.imageView.image = UIImage(data: data)
                print("ASHODHASHDIAHDIUAH \(data)")
            }
        }
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
                    self.showErroEmail(message: "Email digitado errado")
                }
            })
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func showErroEmail(message: String) {
        
        let alert = UIAlertController(title: "Erro", message: message , preferredStyle: .alert)
        
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
