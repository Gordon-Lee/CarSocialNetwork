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
    
    private var userActivityPost: [Activity]! {
        didSet{
          tabbleView.reloadData()
          
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configView()

    }
    
    private func configView() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = AppCongifuration.lightGrey()
    }
    
    private func configTabbleView() {
        tabbleView.delegate = self
        tabbleView.dataSource = self
    }
    
    private func nibCell() {
        let nibCell = UINib(nibName: ActivityView.nibName, bundle: NSBundle.mainBundle())
        tabbleView.registerNib(nibCell, forCellReuseIdentifier: PostTabbleCellView.identifier)
    }
    
    private func setupCell(cell: ActivityView) {
        cell.layoutMargins = UIEdgeInsetsZero
        cell.backgroundColor = AppCongifuration.lightGrey()
    }
}
//MARK: TableView DELEGATE
extension ProfileViewController: UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userActivityPost.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return ActivityView.rowHeight
    }
}
//MARK: TableView DATA SOURCE
extension ProfileViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ActivityView.identifier) as! ActivityView
//        let imageFile = userActivityPost[indexPath.row].image
//        
//        imageFile.getDataInBackgroundWithBlock({ (data, error) in
//            if let image = UIImage(data: data!) {
//                cell.postImage.image = image
//            }
//        })
//        
        setupCell(cell)
        
        return cell
    }
}