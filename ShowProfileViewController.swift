//
//  ProfileViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio on 31/10/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Parse

var userShow = Usr()

class ShowProfileViewController: UIViewController {
    
    static let identifier = "ShowProfileViewController"
    static let storyB = "Show"
    
    fileprivate let cellIdentifier = "actvCell"
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var user: Usr! {
        didSet {
            loadData()
            userShow.profilePhoto?.getDataInBackground(block: { (data, error) in
                if let img = UIImage(data: data!) {
                    self.headerImage.image = img
                }
            })
        }
    }
    
    fileprivate var atvUser = [Activity]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        userShow.profilePhoto?.getDataInBackground(block: { (data, error) in
            if let img = UIImage(data: data!) {
                self.headerImage.image = img
            }
        })
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = userShow.userName
    }
}

extension ShowProfileViewController {
    
    fileprivate func loadData() {
        let query = Activity.query()
        
        query?.includeKey("image")
        query?.whereKey("toUser", equalTo: PFUser.init(withoutDataWithObjectId: userShow.objId))
        query?.whereKey("fromUser", equalTo: PFUser.init(withoutDataWithObjectId: userShow.objId))
        query?.whereKey(Activity.typeaString, equalTo: ActivityType.post.rawValue)
        
        query?.findObjectsInBackground(block: { (actvis, error) in
            if error == nil {
                self.atvUser = actvis as! [Activity]
                print("ACtV USEEERRRRR")
            }
        })
    }
}

extension ShowProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        cell?.textLabel?.text = atvUser[indexPath.row].content
        
        return cell!
    }
}

extension ShowProfileViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return atvUser.count
    }
}
