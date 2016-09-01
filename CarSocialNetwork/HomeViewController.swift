//
//  HomeViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var numberOFRows = 5
    private let cellIdentifier = "homeCell"
    private var refreshControl : UIRefreshControl!

    @IBOutlet weak var tableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(enlargeTable), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(showNavigationBar), forControlEvents: UIControlEvents.TouchDown)
        
    }
    func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.topItem?.title = "Car Social"
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        
    }
    
    func enlargeTable() {
        numberOFRows += 5
        navigationController?.setNavigationBarHidden(false, animated: true)
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOFRows
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "homeCell")
        
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    
}
