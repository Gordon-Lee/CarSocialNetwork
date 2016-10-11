//
//  HomeViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import TLYShyNavBar
import SVProgressHUD
import Parse

class HomeViewController: UIViewController {
    
    static let storyIndentifier = "HomePage"
    
    @IBOutlet weak var tableView: UITableView!
    
    private var refreshControl : UIRefreshControl!
    private var resultName: String!
    private var photoToShow = [Photo]()
    private var activity = [Activity]() {
        didSet {
            tableView.reloadData()
            print(activity.count)
        }
    }
    
    //MARK: Protocol FUNCS
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        nibCell()
        navigationBar()
        configView()
        loadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        SVProgressHUD.show()
        tabBarController?.tabBarVisibility(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        shyNavBarManager.disable = true
    }
    
    //MARK: View FUNCS
    private func loadData() {
        let queryPh = Photo.query()
        let queryActivy = Activity.query()
        
        queryActivy?.whereKey(Activity.typeaString, equalTo: activityType.POST.rawValue)
        
        queryPh?.findObjectsInBackgroundWithBlock({ (photos, error) in
            guard error != nil else {
                self.photoToShow = photos as! [Photo]
                queryActivy?.findObjectsInBackgroundWithBlock({ (activits, error) in
                    guard error != nil else {
                        self.activity = activits as! [Activity]
                        SVProgressHUD.dismiss()
                        return
                    }
                })
                return
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
    
    private func setupCell(cell: PostTabbleCellView) {
        cell.layoutMargins = UIEdgeInsetsZero
        cell.backgroundColor = AppCongifuration.lightGrey()
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
        cell.photoDescription.text = showDescription(photoToShow[indexPath.row].objectId!)
        cell.ownerName.text = resultName
        setupCell(cell)
        
        return cell
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
                return
            }
        })
    }
    private func showDescription(photoId: String) -> String{
        for act in activity {
            if act.image.objectId == photoId {
                return act.content
            }
        }
        return ""
    }
}