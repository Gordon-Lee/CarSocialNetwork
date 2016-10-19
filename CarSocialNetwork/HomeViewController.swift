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
    
    fileprivate var refreshControl : UIRefreshControl!
    fileprivate var resultName: String!
    fileprivate var photoToShow = [Photo]() {
        didSet {
            tableView.reloadData()
            print("#### \(photoToShow.count)")
        }
    }
    fileprivate var activity = [Activity]() {
        didSet {
            tableView.reloadData()
            print("&&&& \(activity.count)")
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBarVisibility(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        shyNavBarManager.disable = true
    }
    
    //MARK: View FUNCS
    fileprivate func loadData() {
        SVProgressHUD.show()
        
        let queryPh = Photo.query()
        let queryActivy = Activity.query()
        
        queryActivy?.whereKey(Activity.typeaString, equalTo: activityType.post.rawValue)
        
        queryPh?.findObjectsInBackground(block: { (photos, error) in
            guard error != nil else {
                self.photoToShow = photos as! [Photo]
                queryActivy?.findObjectsInBackground(block: { (activits, error) in
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
    
    fileprivate func configView() {
        view.backgroundColor = AppCongifuration.lightGrey()
        navigationController?.navigationBar.topItem?.title = "Car Social"
        navigationController?.setNavigationBarHidden(false, animated: true)
        UIApplication.shared.statusBarStyle = .default
    }
    
    fileprivate func tableViewSetup() {
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    fileprivate func navigationBar() {
        shyNavBarManager.contractionResistance = 700
        shyNavBarManager.scrollView = self.tableView
        shyNavBarManager.expansionResistance = 100
        shyNavBarManager.fadeBehavior = .navbar
    }
    
    fileprivate func nibCell() {
        let nibCell = UINib(nibName: PostTabbleCellView.nibName, bundle: Bundle.main)
        tableView.register(nibCell, forCellReuseIdentifier: PostTabbleCellView.identifier)
    }
    
    fileprivate func setupCell(cell: PostTabbleCellView) {
        cell.layoutMargins = UIEdgeInsets.zero
        cell.backgroundColor = AppCongifuration.lightGrey()
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTabbleCellView.identifier) as! PostTabbleCellView
        
        photoToShow[indexPath.row].image.getDataInBackground { (img, error) in
            if let image = UIImage(data: img!) {
                cell.postImage.image = image
            }
        }

        //cell.ownerName.text = queryUser(photoToShow[(indexPath as NSIndexPath).row].owner)
        cell.photoDescription.text = showDescription(photoToShow[indexPath.row].objectId!)
        setupCell(cell: cell)
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate, UIScrollViewDelegate {
    @objc(numberOfSectionsInTableView:) func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoToShow.count
    }
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PostTabbleCellView.rowHeight
    }
}

extension HomeViewController {
    fileprivate func queryUser(_ onwer: PFUser) -> String{
        let query = PFUser.query()
        //query?.whereKey("objectId", equalTo: onwer.objectId)  //AQUI
        var username: String!
        
        query?.getFirstObjectInBackground(block: { (user, eroor) in
            username = user?["username"] as! String
        })
        
        return username
        
        //ANTIGO
//        query?.findObjectsInBackground(block: { (users, error) in
//            for us in users! {
//                self.resultName = us["username"] as! String
//                return
//            }
//        })
    }
    fileprivate func showDescription(_ photoId: String) -> String{
        for act in activity {
            if act.image.objectId == photoId {
                return act.content
            }
        }
        return ""
    }
}
