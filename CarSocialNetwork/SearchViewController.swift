//
//  SearchViewController.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 8/31/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD

enum dataToDisplay {
    case car, events, people
}

class SearchViewController: UIViewController {
    //TODO only for testing
    var car = ["VW", "FORD", "GM", "FIAT"]
    var eventArray = ["aa","bb","cc","dd"]
    var people = ["ss", "ww", "rr"]
    //Data from Parse
    fileprivate var cars = [Car]()
    fileprivate var events = [Events]()
    fileprivate var peoples = [User]()
    
    var dataDisplay : dataToDisplay = .events
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var eventsBt: UIButton!
    @IBOutlet weak var peopleBt: UIButton!
    @IBOutlet weak var carBt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
        configView()
    }
    fileprivate func configView() {
        view.backgroundColor = AppCongifuration.mediumGrey()
    }
}
//MARK: Load data From Parse
extension SearchViewController {
    fileprivate func loadCars() {
        let queryCar = Car.query()
        
        queryCar?.findObjectsInBackground(block: { (carLoad, error) in
            guard error != nil else {
                self.cars = carLoad as! [Car]
                return
            }
        })
    }
    
    fileprivate func loadEvents() {
        let queryEvents = Even
    }

    
}
//MARK: ACTIONS
extension SearchViewController {
    @IBAction func showTableViewPeople(_ sender: AnyObject) {
        dataDisplay = .people
        tableView.reloadData()
    }
    
    @IBAction func showTableViewEvents(_ sender: AnyObject) {
        dataDisplay = .events
        print(dataDisplay)
        tableView.reloadData()
    }
    
    @IBAction func showTableViewCars(_ sender: AnyObject) {
        dataDisplay = .car
        print(dataDisplay)
        tableView.reloadData()
    }
}

//MARK: TABLEVIEW PROTOCOLS
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        switch dataDisplay {
        case .car:
            cell?.textLabel?.text = car[indexPath.row]
        case .events:
            cell?.textLabel?.text = eventArray[indexPath.row]
        case .people:
            cell?.textLabel?.text = people[indexPath.row]
        }
        return cell!
    }
}

extension SearchViewController: UITableViewDelegate {
    @objc(numberOfSectionsInTableView:) func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dataDisplay {
        case .car:
            return car.count
        case .events:
            return eventArray.count
        case .people:
            return people.count
        }
    }
}
