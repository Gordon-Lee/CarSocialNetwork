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
    fileprivate var peoples = [Usr]()  {
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
    @IBOutlet weak var buttonStand: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nibCell()
        loadEvents()
        loadCars()
        loadPeople()
        
        //searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        // Setup the Scope Bar
        setButtonsImage()
        setScopeBar(display: dataDisplay)
        searchController.searchBar.backgroundColor = AppCongifuration.lightGrey()
        searchController.searchBar.tintColor = AppCongifuration.blue()
        buttonStand.addSubview(searchController.searchBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
        configView()
    }
    
    fileprivate func setButtonsImage() {
        eventsBt.setImage(UIImage(named: "eventsNormal"), for: .normal)
        eventsBt.setImage(UIImage(named: "eventsSelected"), for: .selected)
        carBt.setImage(UIImage(named: "carsNormal"), for: .normal)
        carBt.setImage(UIImage(named: "carsHigh"), for: .selected)
        peopleBt.setImage(UIImage(named: "peopleNormal"), for: .normal)
        peopleBt.setImage(UIImage(named: "peopleHigh"), for: .selected)
    }
    
    fileprivate func setScopeBar(display: dataToDisplay) {
        switch display {
        case .events:
            eventsBt.isSelected = true
            carBt.isSelected = false
            peopleBt.isSelected = false
            searchController.searchBar.scopeButtonTitles = ["local", "cidade"]
        case .car:
            eventsBt.isSelected = false
            carBt.isSelected = true
            peopleBt.isSelected = false
            searchController.searchBar.scopeButtonTitles = ["modelo", "marca", "ano"]
        case .people:
            eventsBt.isSelected = false
            carBt.isSelected = false
            peopleBt.isSelected = true
            searchController.searchBar.scopeButtonTitles = ["nome","sexo"]
        }
    }

    //TODOOO
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
        let queryPeople = PFUser.query()
        
        queryPeople?.findObjectsInBackground(block: { (people, error) in
            for us in people! {
                let u = us as! PFUser
                self.peoples.append(Usr(obejctId: u.objectId!,
                                    username: u.username,
                                    email: u.email,
                                    thumbImage: us["thumbImage"] as! PFFile?,
                                    photo: us["profileImage"] as! PFFile? ))
            }
        })
    }
    
    fileprivate func loadImage(image: PFFile, cell: SearchTableViewCell) {
        image.getDataInBackground { (img, error) in
            if let image = UIImage(data: img!) {
                cell.searchIMG.image = image
            }
        }
    }
    
}
//MARK: ACTIONS
extension SearchViewController {
    @IBAction func showTableViewPeople(_ sender: AnyObject) {
        dataDisplay = .people
        setScopeBar(display: dataDisplay)
        print(dataDisplay)
        tableView.reloadData()
    }
    
    @IBAction func showTableViewEvents(_ sender: AnyObject) {
        dataDisplay = .events
        setScopeBar(display: dataDisplay)
        print(dataDisplay)
        tableView.reloadData()
    }
    
    @IBAction func showTableViewCars(_ sender: AnyObject) {
        dataDisplay = .car
        setScopeBar(display: dataDisplay)
        print(dataDisplay)
        tableView.reloadData()
    }
    
    fileprivate func stateButtons( ) {
        
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
            loadImage(image: cars[indexPath.row].thumbImage, cell: cell)
        case .events:
            cell.content.text = events[indexPath.row].eventDescription
            loadImage(image: events[indexPath.row].image, cell:  cell)
        case .people:
            cell.content.text = peoples[indexPath.row].userName
            print(peoples[indexPath.row].thumbImage)
            
            if peoples[indexPath.row].thumbImage != nil {
                loadImage(image: peoples[indexPath.row].thumbImage!, cell: cell)
            }
        }
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchTableViewCell.rowHeight
    }
    
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
