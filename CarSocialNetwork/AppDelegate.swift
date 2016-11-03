//
//  AppDelegate.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/11/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import FBSDKLoginKit
import ParseFacebookUtilsV4
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    fileprivate let loginSBIdentifier = "LoginStory"
    fileprivate let homePageIdentifier = "HomePage"
    fileprivate let inicialTutorialIdentifier = "InicialTutorial"
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        configureParse()
        PFAnalytics.trackAppOpenedWithLaunchOptions(inBackground: launchOptions, block: nil)
        PFFacebookUtils.initializeFacebook()
        
        AppCongifuration.systemBars()
        setIncialStoryBoard()
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) {

        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

extension AppDelegate {
    
    fileprivate func configureParse() {
        User.registerSubclass()
        Car.registerSubclass()
        Events.registerSubclass()
        Activity.registerSubclass()
        Photo.registerSubclass()
        
        Parse.setApplicationId("kByO4d8lpQ0ZtL6O5Aql0NctUpz8UOCA5W246HQv", clientKey: "3Gk9I2vhUReAcTrGZwDaJWCVaDW0OXwVKXWYHoGv")
    }
    
    fileprivate func setIncialStoryBoard() {
        goToStoryBoard(loginSBIdentifier)
        //print(UserDefaults.sharedInstance.getUserName())
//        if !UserDefaults.sharedInstance.isFirtTime() {
//            goToStoryBoard(self.inicialTutorialIdentifier)
//            return
//        }
//        if UserDefaults.sharedInstance.autoLogin() {
//            let userName = UserDefaults.sharedInstance.getUserName()
//            let password = UserDefaults.sharedInstance.getPassword()
//            loginWithParse(userName, password: password)
//        } else if !UserDefaults.sharedInstance.autoLogin() {
//            goToStoryBoard(loginSBIdentifier)
//        }
    }
    
    fileprivate func loginWithParse(_ username: String!, password: String!) {
        //SVProgressHUD.show()
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) -> Void in
            if user != nil {
                self.goToStoryBoard(self.homePageIdentifier)
                //SVProgressHUD.dismiss()
                return
            }
        }
    }
    
    fileprivate func goToStoryBoard(_ initialSb: String) {
        let sb = UIStoryboard(name: initialSb, bundle: Bundle.main)
        let vc = sb.instantiateInitialViewController()
        window?.rootViewController = vc
    }
    
    
}

