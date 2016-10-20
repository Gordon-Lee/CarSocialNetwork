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
    
    fileprivate var userActivityPost = [Activity]() {
        didSet{
          tableView.reloadData()
            for us in userActivityPost {
                print(us.image.objectId)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nibCell()
        loadData()
        navigationController?.navigationBar.topItem?.title = "Perfil"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configView()
    }
    
    fileprivate func configView() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = AppCongifuration.lightGrey()
    }
    
    @IBAction func settings(_ sender: AnyObject) {
        let sb = UIStoryboard(name: CarViewController.identifier, bundle: Bundle.main)
        let vc = sb.instantiateInitialViewController() as! CarViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func loadData() {
        let query = Activity.query()
        query?.whereKey("fromUser", equalTo: PFUser.current()!)
        query?.whereKey("toUser", equalTo: PFUser.current()!)
        query?.findObjectsInBackground(block: { (activits, error) in
            guard error != nil else {
                self.userActivityPost = activits as! [Activity]
                return
            }
        })
    }
}
//MARK: Generic Methods / Actions
extension ProfileViewController {
    fileprivate func nibCell() {
        let nibCell = UINib(nibName: UserActivityTableViewCell.nibName, bundle: Bundle.main)
        tableView.register(nibCell, forCellReuseIdentifier: UserActivityTableViewCell.identifier)
    }
    
    fileprivate func setupCell(cell: UserActivityTableViewCell) {
        cell.layoutMargins = UIEdgeInsets.zero
        cell.backgroundColor = AppCongifuration.lightGrey()
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
        
        cell.actvDescription.text = "\(indexPath.row)"
        
        return cell
    }
}
