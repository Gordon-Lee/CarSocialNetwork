//
//  SearchViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
        configView()
    }
    fileprivate func configView() {
        view.backgroundColor = AppCongifuration.mediumGrey()
    }
    
    @IBAction func showTableViewEvents(_ sender: AnyObject) {
    }
    
    @IBAction func showTableViewCars(_ sender: AnyObject) {
    }
    
}
