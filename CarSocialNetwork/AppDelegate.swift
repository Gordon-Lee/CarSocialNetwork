//
//  AppDelegate.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/11/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let loginSBIdentifier = "LoginStory"
    private let homePageIdentifier = "HomePage"
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        configureParse()
        AppCongifuration.systemBars()
        setIncialStoryBoard()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }
    
    private func configureParse() {
        //User.registerSubclass()
        //Car.registerSubclass()
        //Events.registerSubclass()
        Activity.registerSubclass()
        Photo.registerSubclass()
        
        Parse.setApplicationId("kByO4d8lpQ0ZtL6O5Aql0NctUpz8UOCA5W246HQv", clientKey: "3Gk9I2vhUReAcTrGZwDaJWCVaDW0OXwVKXWYHoGv")
    }
    
    private func setIncialStoryBoard() {
        if UserDefaults.sharedInstance.login() && UserDefaults.sharedInstance.autoLogin() {
            UserDefaults.sharedInstance.setAutoLogin(true)
        } else {
            goToStoryBoard(loginSBIdentifier)
        }
    }
    
    private func goToStoryBoard(initialSb: String) {
        let sb = UIStoryboard(name: initialSb, bundle: NSBundle.mainBundle())
        let vc = sb.instantiateInitialViewController()
        window?.rootViewController = vc
    }
}