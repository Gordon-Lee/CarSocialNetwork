//
//  ProfileViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    
    fileprivate var userActivityPost = [Activity]() {
        didSet{
          tableView.reloadData()
        }
    }
    
    fileprivate var usr: Usr! {
        didSet {
            usr.thumbImage?.getDataInBackground(block: { (data, error) in
                if let image = UIImage(data: data!) {
                    self.profilePhoto.image = image
                }
            })
            usernameLbl.text = usr.userName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nibCell()
        loadData()
        loadUsrData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configView()
    }
    
    fileprivate func configView() {
        navigationController?.navigationBar.topItem?.title = "Perfil"
        navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = AppCongifuration.lightGrey()
    }
    
    @IBAction func settings(_ sender: AnyObject) {
        let sb = UIStoryboard(name: EditViewController.identifier, bundle: Bundle.main)
        let vc = sb.instantiateInitialViewController() as! EditViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func nibCell() {
        let nibCell = UINib(nibName: UserActivityTableViewCell.nibName, bundle: Bundle.main)
        tableView.register(nibCell, forCellReuseIdentifier: UserActivityTableViewCell.identifier)
    }
    
    fileprivate func setupCell(cell: UserActivityTableViewCell) {
        cell.layoutMargins = UIEdgeInsets.zero
        cell.backgroundColor = AppCongifuration.lightGrey()
    }
}

//MARK: Generic Methods / Actions
extension ProfileViewController {
    
    fileprivate func loadData() {
        let query = Activity.query()
        query?.whereKey("fromUser", equalTo: PFUser.current()!)
        query?.whereKey("toUser", equalTo: PFUser.current()!)
        query?.whereKey("activityType", equalTo: 0)
        query?.addDescendingOrder("createdAt")
        query?.includeKey("image")
        query?.findObjectsInBackground(block: { (activits, error) in
            guard error != nil else {
                self.userActivityPost = activits as! [Activity]
                return
            }
        })
    }
    
    fileprivate func loadUsrData() {
        let queryUser = PFUser.query()
      //  queryUser?.whereKey("objectId", equalTo: PFUser.current()?.objectId)
        queryUser?.getFirstObjectInBackground(block: { (user, error) in
            guard error != nil else {
                let u = user as! PFUser
                self.usr = Usr(obejctId: u.objectId!,
                               username: u.username,
                               email: u.email,
                               thumbImage: user?["thumbImage"] as! PFFile?,
                               photo: user?["profileImage"] as! PFFile?)

                return
            }
            
        })
    }
}

//MARK: TableView DELEGATE
extension ProfileViewController: UITableViewDelegate {
    
    @objc(numberOfSectionsInTableView:) func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userActivityPost.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 as CGFloat
    }
}
//MARK: TableView DATA SOURCE
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserActivityTableViewCell.identifier) as! UserActivityTableViewCell
        
        userActivityPost[indexPath.row].image.thumbImage.getDataInBackground(block: { (data, error) in
            if let image = UIImage(data: data!) {
                cell.imageUser.image = image
                return
            }
        })
        
        cell.actvDescription.text = userActivityPost[indexPath.row].content
        
        return cell
    }
}
