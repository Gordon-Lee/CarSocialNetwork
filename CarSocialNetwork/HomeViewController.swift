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
    
    fileprivate var usr = [Usr]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    fileprivate var users: [User]! {
        didSet {
            print("USERSSS \(users.count)")
        }
    }
    
    fileprivate var photoToShow = [Photo]() {
        didSet {
            tableView.reloadData()
            print("#### \(photoToShow.count)")
            for ph in photoToShow {
                print(ph.owner.objectId)
            }
        }
    }
    
    fileprivate var activity = [Activity]() {
        didSet {
            tableView.reloadData()
            print("&&&& \(activity.count)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        queryUser()
        tableViewSetup()
        nibCell()
        navigationBarSHY()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        shyNavBarManager.disable = true
    }
    
    fileprivate func configView() {
        UIApplication.shared.statusBarStyle = .default
        view.backgroundColor = AppCongifuration.lightGrey()
        tabBarController?.tabBarVisibility(true, animated: true)
        
        navigationController?.navigationBar.barTintColor = AppCongifuration.lightGrey()
        navigationController?.navigationBar.topItem?.title = "Car Social"
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
}
//MARK: Parse FUNCTIONS
extension HomeViewController {
    
    fileprivate func loadData() {
        SVProgressHUD.show()
        
        let queryPh = Photo.query()
        let queryActivy = Activity.query()
        
        queryPh?.includeKey("owner")
        queryActivy?.whereKey(Activity.typeaString, equalTo: activityType.post.rawValue)
        queryActivy?.includeKey("image")
    
        queryPh?.findObjectsInBackground(block: { (photos, error) in
            guard error != nil else {
                self.photoToShow = photos as! [Photo]
                return
            }
        })
        
        queryActivy?.findObjectsInBackground(block: { (activits, error) in
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
    
    fileprivate func showDescription(_ photoId: String) -> String{
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
        
        //queryUser(photoToShow[(indexPath as NSIndexPath).row].owner)
        
        photoToShow[indexPath.row].image.getDataInBackground { (img, error) in
            if let image = UIImage(data: img!) {
                cell.postImage.image = image
            }
        }
        
        if thumbImage != nil {
            thumbImage!.getDataInBackground { (data, error) in
                if let img = UIImage(data: data!) {
                    cell.thumbPhoto.image = img
                }
            }
        }
        
        cell.user = photoToShow[indexPath.row].owner
        cell.ownerName.text = userName(id: photoToShow[indexPath.row].owner)
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
