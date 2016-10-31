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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    fileprivate let loginSBIdentifier = "LoginStory"
    fileprivate let homePageIdentifier = "HomePage"
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

//    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
//        let option = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: String(describing: options), annotation: options)
//        
//        return option
//    }
    
//    private func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
//        r
//    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
//        //FBAppCall.handleDidBecomeActiveWithSession(PFFacebookUtils.session())
//        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    fileprivate func configureParse() {
        User.registerSubclass()
        Car.registerSubclass()
        Events.registerSubclass()
        Activity.registerSubclass()
        Photo.registerSubclass()

        Parse.setApplicationId("kByO4d8lpQ0ZtL6O5Aql0NctUpz8UOCA5W246HQv", clientKey: "3Gk9I2vhUReAcTrGZwDaJWCVaDW0OXwVKXWYHoGv")
    }
    
//    func application(application: UIApplication,
//                     openURL url: URL,
//                     sourceApplication: String?,
//                     annotation: Any?) -> Bool {
//        return FBAppCall.handleOpenURL(url, sourceApplication:sourceApplication,
//                                       withSession:PFFacebookUtils.session())
//    }
    
    fileprivate func setIncialStoryBoard() {
        if UserDefaults.sharedInstance.login() && UserDefaults.sharedInstance.autoLogin() {
            UserDefaults.sharedInstance.setAutoLogin(true)
        } else {
            goToStoryBoard(loginSBIdentifier)
        }
    }
    
    fileprivate func goToStoryBoard(_ initialSb: String) {
        let sb = UIStoryboard(name: initialSb, bundle: Bundle.main)
        let vc = sb.instantiateInitialViewController()
        window?.rootViewController = vc
    }
}
