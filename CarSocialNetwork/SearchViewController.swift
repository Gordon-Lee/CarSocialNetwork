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
    fileprivate var cars = [Car]() {
        didSet {
           tableView.reloadData()
        }
    }
    fileprivate var events = [Events]()  {
        didSet {
            tableView.reloadData()
        }
    }
    fileprivate var peoples = [User]()  {
        didSet {
            print("\(peoples.count)    ******* PEOPLE ######")
            tableView.reloadData()
        }
    }
    
    var dataDisplay : dataToDisplay = .events
    @IBOutlet weak var searchBar: UIView!
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var eventsBt: UIButton!
    @IBOutlet weak var peopleBt: UIButton!
    @IBOutlet weak var carBt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nibCell()
        loadCars()
        loadEvents()
        loadPeople()
        
        //searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
        tableView.tableHeaderView = searchController.searchBar

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
        configView()
    }
    
    fileprivate func configSearchController() {
        //searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
    }
    
    fileprivate func configView() {
        view.backgroundColor = AppCongifuration.mediumGrey()
    }
    
    fileprivate func nibCell() {
        let nibCell = UINib(nibName: SearchTableViewCell.xibName, bundle: Bundle.main)
        tableView.register(nibCell, forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
}
//MARK: Load data From Parse
extension SearchViewController {
    fileprivate func loadCars() {
        let queryCar = Car.query()
        
        queryCar?.findObjectsInBackground(block: { (carLoad, error) in
            guard error != nil else {
                self.cars = carLoad as! [Car]
                 print("\(self.cars.count)    ******* CCARRSSSSS #######")
                return
            }
        })
    }
    
    fileprivate func loadEvents() {
        let queryEvents = Events.query()
        
        queryEvents?.findObjectsInBackground(block: { (events, error) in
            guard error != nil else {
                self.events = events as! [Events]
                print("\(self.events.count)    ******* EVVEEENTSSSS ######")
                return
            }
        })
    }
    
    fileprivate func loadPeople() {
        let queryPeople = User.query()
        
        queryPeople?.findObjectsInBackground(block: { (people, error) in
            guard error != nil else {
                self.peoples = people as! [User]
                return
            }
        })
    }
}
//MARK: ACTIONS
extension SearchViewController {
    @IBAction func showTableViewPeople(_ sender: AnyObject) {
        dataDisplay = .people
        print(dataDisplay)
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
//MARK: Search Bar
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        let filteredCars = cars.filter { carr in
            let categoryMatch = (scope == "All") || (carr.brand == scope)
            return  categoryMatch && carr.brand.localizedLowercase.contains(searchText.localizedLowercase)
        }
        tableView.reloadData()
    }
    func updateSearchResultsForSearchController(searchController: UISearchController) {
    //    let searchBar = searchBar.searchBar
    //    let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    //    filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}
//MARK: TABLEVIEW PROTOCOLS
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as! SearchTableViewCell
        
        switch dataDisplay {
        case .car:
            cell.content.text = cars[indexPath.row].brand
            cell.searchIMG.image = cars[indexPath.row].fileToImage()
        case .events:
            cell.content.text = events[indexPath.row].eventDescription
            cell.searchIMG.image = events[indexPath.row].fileToImage()
        case .people:
            cell.content.text = peoples[indexPath.row].username
            cell.searchIMG.image = peoples[indexPath.row].fileToImage()
        }
        return cell
    }
}
extension SearchViewController: UITableViewDelegate {
    @objc(numberOfSectionsInTableView:) func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dataDisplay {
        case .car:
            print(cars.count)
            return cars.count
        case .events:
            print(events.count)
            return events.count
        case .people:
            print(peoples.count)
            return peoples.count
        }
    }
}
