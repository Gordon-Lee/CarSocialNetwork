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

    @IBOutlet weak var tabbleView: UITableView!
    
    fileprivate var userActivityPost = [Activity]() {
        didSet{
          tabbleView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabbleView()
        nibCell()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configView()

    }
    
    fileprivate func configView() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = AppCongifuration.lightGrey()
    }
    
    @IBAction func settings(_ sender: AnyObject) {
        let sb = UIStoryboard(name:CarViewController.identifier, bundle: Bundle.main)
        let vc = sb.instantiateInitialViewController() as! CarViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    fileprivate func loadData() {
        let query = Activity.query()
        
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
    fileprivate func configTabbleView() {
        tabbleView.delegate = self
        tabbleView.dataSource = self
    }
    
    fileprivate func nibCell() {
        let nibCell = UINib(nibName: ActivityView.nibName, bundle: Bundle.main)
        tabbleView.register(nibCell, forCellReuseIdentifier: PostTabbleCellView.identifier)
    }
    
    fileprivate func setupCell(cell: ActivityView) {
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
        return ActivityView.rowHeight
    }
}
//MARK: TableView DATA SOURCE
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityView.identifier) as! ActivityView

//        imageFile.getDataInBackgroundWithBlock({ (data, error) in
//            if let image = UIImage(data: data!) {
//                cell.postImage.image = image
//            }
//        })
        
        setupCell(cell: cell)
        
        return cell
    }
}
