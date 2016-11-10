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
    fileprivate var thumbImage: PFFile!
    
    //fileprivate var users: [User]!
    
    fileprivate var usr = [Usr]() {
        didSet {
            tableView.reloadData()
        }
    }

    fileprivate var photoToShow = [Photo]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    fileprivate var activity = [Activity]() {
        didSet {
            tableView.reloadData()
            print("&&&& \(activity.count)")
            var i = 1
            for ac in activity {
                print("\(i) IMAGEID \(ac.image.objectId)")
                i += i
            }
        }
    }
    
    fileprivate var userActivityCurrentLike = [Activity]()
    
    var userId = PFUser()
    var image = Photo()
    
    var reloadData = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("current \(PFUser.current()?.objectId)")
        loadPostData()
        loadActivityData()
        queryUser()
        tableViewSetup()
        nibCell()
        navigationBarSHY()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if reloadData {
            loadPostData()
            loadActivityData()
            reloadData = false
        }
        configView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        shyNavBarManager.disable = true
    }
}
//MARK: Parse FUNCTIONS
extension HomeViewController {
    
    fileprivate func configView() {
        UIApplication.shared.statusBarStyle = .default
        view.backgroundColor = AppCongifuration.lightGrey()
        tabBarController?.tabBarVisibility(true, animated: true)
        
        navigationController?.navigationBar.barTintColor = AppCongifuration.lightGrey()
        navigationController?.navigationBar.topItem?.title = "Car Social"
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    fileprivate func tableViewSetup() {
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    fileprivate func navigationBarSHY() {
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
    //PARSE
    fileprivate func loadPostData() {
        SVProgressHUD.show()
        
        let queryPh = Photo.query()
        
        queryPh?.includeKey("owner")
        queryPh?.addDescendingOrder("createdAt")
        
        queryPh?.findObjectsInBackground(block: { (photos, error) in
            guard error != nil else {
                self.photoToShow = photos as! [Photo]
                return
            }
        })
    }
    
    fileprivate func loadActivityData() {
        let query = Activity.query()
        SVProgressHUD.show()
        query?.whereKey("fromUser", equalTo: PFUser.current()!)
        
        query?.includeKey("image")
        query?.whereKey(Activity.typeaString, equalTo: ActivityType.like.rawValue)
        query?.findObjectsInBackground(block: { (activits, error) in
            guard error != nil else {
                self.activity = activits as! [Activity]
                return
            }
        })
    }
    
    fileprivate func queryUser() {
        let query = PFUser.query()
        
        query?.findObjectsInBackground(block: { (users, error) in
            for us in users! {
                let u = us as! PFUser
                self.usr.append(Usr(obejctId: u.objectId!,
                                    username: u.username,
                                    email: u.email,
                                    thumbImage: us["thumbImage"] as! PFFile?,
                                    photo: us["profileImage"] as! PFFile? ))
            }
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        })
    }
    
    fileprivate func showDescription(_ photoId: String) -> String {
        for act in activity {
            if act.image.objectId == photoId {
                return act.content
            }
        }
        return ""
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTabbleCellView.identifier) as! PostTabbleCellView
        
        cell.delegate = self
        
        photoToShow[indexPath.row].image.getDataInBackground { (img, error) in
            if let image = UIImage(data: img!) {
                cell.postImage.image = image
                cell.like.isSelected = self.isLiked(imageId: self.photoToShow[indexPath.row].objectId!)
            }
        }
        
        let thumb = photoToShow[indexPath.row].owner["thumbImage"] as! PFFile
        
        thumb.getDataInBackground { (data, error) in
            if let imgData = UIImage(data: data!) {
                cell.thumbPhoto.image = imgData
            }
        }
        
        cell.ownerName.text = photoToShow[indexPath.row].owner.username
        cell.postDescription.text = showDescription(photoToShow[indexPath.row].objectId!)
        setupCell(cell: cell)
        
        return cell
    }
    
    fileprivate func isLiked(imageId: String) -> Bool {
        for a in activity {
            if a.image.objectId == imageId {
                return true
            }
        }
        return false
    }
    
    fileprivate func userName(id: PFUser) -> String {
        for u in usr {
            if u.objId == id.objectId {
                self.thumbImage = u.thumbImage
                return u.userName!
            }
        }
        return ""
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("SELECTED ROW")
        print(indexPath.row)
        print(photoToShow[indexPath.row].owner.objectId!)
        userId = photoToShow[indexPath.row].owner 
        image = photoToShow[indexPath.row]
    }
}

extension HomeViewController: PostTableViewDelegate {
    func didTapProfile() {
        
    }
    func likePhoto() {
        let actv = Activity()
        actv.fromUser = PFUser.current()!
        actv.toUser = userId
        actv.activityType = ActivityType.like.rawValue
        actv.image = image
        actv.saveInBackground(block: { (sucess, error) in
            if sucess {
                print("SAVVVEEEEEEE")
            }
        })
    }
}
