//
//  HomeViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import TLYShyNavBar

class HomeViewController: UIViewController {
    
    private var numberOFRows = 25
    private let cellIdentifier = "homeCell"
    private var refreshControl : UIRefreshControl!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nibCell()
        navigationBar()
//        refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(enlargeTable), forControlEvents: UIControlEvents.ValueChanged)
//        tableView.addSubview(refreshControl)
//        refreshControl.addTarget(self, action: #selector(showNavigationBar), forControlEvents: UIControlEvents.TouchDown)
        
    }
    private func navigationBar() {
        self.shyNavBarManager.scrollView = self.tableView
        self.shyNavBarManager.expansionResistance = 30
        self.shyNavBarManager.fadeBehavior = .Subviews
    }
    
    private func nibCell() {
        let nibCell = UINib(nibName: PostTabbleCellView.nibName, bundle: NSBundle.mainBundle())
        tableView.registerNib(nibCell, forCellReuseIdentifier: PostTabbleCellView.identifier)
    }
    
    private func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.topItem?.title = "Car Social"
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func enlargeTable() {
        numberOFRows += 5
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UIScrollViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOFRows
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(PostTabbleCellView.identifier) as! PostTabbleCellView
        
        cell.ownerName.text = "hahaha"
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return PostTabbleCellView.rowHeight
    }
}