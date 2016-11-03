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
        nibCell()
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
    fileprivate func nibCell() {
        let nibCell = UINib(nibName: UserActivityTableViewCell.nibName, bundle: Bundle.main)
        tableView.register(nibCell, forCellReuseIdentifier: UserActivityTableViewCell.identifier)
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
            }
        })
    }
}

extension ShowProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserActivityTableViewCell.identifier) as! UserActivityTableViewCell
        
        atvUser[indexPath.row].image.thumbImage.getDataInBackground(block: { (data, error) in
            if let image = UIImage(data: data!) {
                cell.imageUser.image = image
                //TODO
                cell.actvDescription.text = self.atvUser[indexPath.row].content
                cell.like.isHidden = true
                return
            }
        })
        return cell
    }
}

extension ShowProfileViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return atvUser.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110 as CGFloat
    }
}
