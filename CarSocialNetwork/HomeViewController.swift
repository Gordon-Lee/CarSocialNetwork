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
    private var refreshControl : UIRefreshControl!

    let aqui = ":"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        nibCell()
        navigationBar()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        configView()
        navigationController?.navigationBar.topItem?.title = "Car Social"
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        shyNavBarManager.disable = true
    }
    
    private func configView() {
        view.backgroundColor = AppCongifuration.lightGrey()
    }
    
    private func tableViewSetup() {
        tableView.layoutMargins = UIEdgeInsetsZero
        tableView.separatorInset = UIEdgeInsetsZero
    }
    
    private func navigationBar() {
        shyNavBarManager.contractionResistance = 700
        shyNavBarManager.scrollView = self.tableView
        shyNavBarManager.expansionResistance = 100
        shyNavBarManager.fadeBehavior = .Navbar
    }
    
    private func nibCell() {
        let nibCell = UINib(nibName: PostTabbleCellView.nibName, bundle: NSBundle.mainBundle())
        tableView.registerNib(nibCell, forCellReuseIdentifier: PostTabbleCellView.identifier)
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
        
        setupCell(cell)
        
        return cell
    }
    
    private func setupCell(cell: PostTabbleCellView) {
        cell.layoutMargins = UIEdgeInsetsZero
        cell.backgroundColor = AppCongifuration.lightGrey()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return PostTabbleCellView.rowHeight
    }
}