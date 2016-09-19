//
//  HomeViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Parse
import TLYShyNavBar
import SVProgressHUD

class HomeViewController: UIViewController {
    
    private var refreshControl : UIRefreshControl!
    private var resultName: String!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var photoToShow = [Photo]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: Protocol FUNCS
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        nibCell()
        navigationBar()
        loadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        SVProgressHUD.show()
        configView()
        loadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        shyNavBarManager.disable = true
    }
    
    //MARK: View FUNCS
    private func loadData() {
        SVProgressHUD.setBackgroundColor(AppCongifuration.darkGrey())
        let query = Photo.query()
        query?.findObjectsInBackgroundWithBlock({ (photos, error) in
            if error == nil {
                self.photoToShow = photos as! [Photo]
            } else {
                SVProgressHUD.showErrorWithStatus(error?.localizedDescription)
            }
        })
    }
    
    private func configView() {
        view.backgroundColor = AppCongifuration.lightGrey()
        navigationController?.navigationBar.topItem?.title = "Car Social"
        navigationController?.setNavigationBarHidden(false, animated: true)
        UIApplication.sharedApplication().statusBarStyle = .Default
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
        return photoToShow.count
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        queryUser(photoToShow[indexPath.row].owner)
        
        let cell = tableView.dequeueReusableCellWithIdentifier(PostTabbleCellView.identifier) as! PostTabbleCellView
        let imageFile = photoToShow[indexPath.row].image
        
        imageFile.getDataInBackgroundWithBlock({ (data, error) in
            if let image = UIImage(data: data!) {
                cell.postImage.image = image
            }
        })
        
        cell.ownerName.text = resultName
        
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

extension HomeViewController {

    private func queryUser(onwer: PFUser){
        let query = PFUser.query()
        query?.findObjectsInBackgroundWithBlock({ (users, error) in
            for us in users! {
                self.resultName = us["username"] as! String
                self.tableView.reloadData()
                SVProgressHUD.dismiss()
                return
            }
        })
    }
}