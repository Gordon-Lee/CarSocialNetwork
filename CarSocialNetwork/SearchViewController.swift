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

enum dataToDisplay: Int {
    case car, events, people
    
    var asString: String {
        switch self {
        case .car:
            return "Carro"
        case .events:
            return "Eventos"
        case .people:
            return "Pessoas"
        }
    }
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
            tableView.reloadData()
        }
    }

    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate var filteredCar = [Car]()
    fileprivate var filteredEvents = [Events]()
    fileprivate var filteredPeople = [Usr]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var eventsBt: UIButton!
    @IBOutlet weak var peopleBt: UIButton!
    @IBOutlet weak var carBt: UIButton!
    @IBOutlet weak var buttonStand: UIView!
    
    var dataDisplay : dataToDisplay = .events
    fileprivate var userSelected: Usr!
    fileprivate var eventSelected: Events!
    fileprivate var carSelected: Car!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonsImage()
        configSearch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadEvents()
        loadCars()
        loadPeople()
        nibCell()
        configView()
        showNavigation()
    }
}
//MARK: Load data and Generic Methods
extension SearchViewController {
    
    fileprivate func configSearch() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        setScopeBar(display: dataDisplay)
        searchController.searchBar.backgroundColor = AppCongifuration.lightGrey()
        searchController.searchBar.tintColor = AppCongifuration.blue()
        buttonStand.addSubview(searchController.searchBar)
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
            searchController.isActive = false
            eventsBt.isSelected = true
            carBt.isSelected = false
            peopleBt.isSelected = false
            searchController.searchBar.scopeButtonTitles = ["nome", "cidade"]
        case .car:
            searchController.isActive = false
            navigationController?.navigationBar.topItem?.title = "Carros"
            eventsBt.isSelected = false
            carBt.isSelected = true
            peopleBt.isSelected = false
            searchController.searchBar.scopeButtonTitles = ["modelo", "marca", "ano"]
        case .people:
            searchController.isActive = false
            navigationController?.navigationBar.topItem?.title = "Motoras"
            eventsBt.isSelected = false
            carBt.isSelected = false
            peopleBt.isSelected = true
            searchController.searchBar.scopeButtonTitles = ["Nome"]
        }
    }
    
    fileprivate func configView() {
        view.backgroundColor = AppCongifuration.mediumGrey()
    }
    
    fileprivate func showNavigation() {
        let show = dataDisplay == .events ? true : false
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        if show {
            navigationController?.navigationBar.topItem?.title = "Eventos"
            navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Novo", style: .plain, target: self, action: #selector(SearchViewController.newEvent))
            return
        } else {
            navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        }
    }
    
    func newEvent() {
        let sb = UIStoryboard(name: EventsViewController.identifier, bundle: Bundle.main)
        let vc = sb.instantiateInitialViewController() as! EventsViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }

    fileprivate func nibCell() {
        let nibCell = UINib(nibName: SearchTableViewCell.xibName, bundle: Bundle.main)
        tableView.register(nibCell, forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
    fileprivate func loadCars() {
        let queryCar = Car.query()
        queryCar?.includeKey("owner")
    
        queryCar?.findObjectsInBackground(block: { (carLoad, error) in
            guard error != nil else {
                self.cars = carLoad as! [Car]
                return
            }
        })
    }
    
    fileprivate func loadEvents() {
        let queryEvents = Events.query()
        
        queryEvents?.findObjectsInBackground(block: { (ev, error) in
            guard error != nil else {
                self.events = ev as! [Events]
                return
            }
        })
    }
    
    fileprivate func loadPeople() {
        let queryPeople = PFUser.query()
        print("Current \(PFUser.current()?.objectId)")
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
                return
            }
        }
    }
}
//MARK: ACTIONS
extension SearchViewController {
    @IBAction func showTableViewPeople(_ sender: AnyObject) {
        dataDisplay = .people
        showNavigation()
        setScopeBar(display: dataDisplay)
        tableView.reloadData()
    }
    
    @IBAction func showTableViewEvents(_ sender: AnyObject) {
        dataDisplay = .events
        showNavigation()
        setScopeBar(display: dataDisplay)
        tableView.reloadData()
    }
    
    @IBAction func showTableViewCars(_ sender: AnyObject) {
        dataDisplay = .car
        showNavigation()
        setScopeBar(display: dataDisplay)
        tableView.reloadData()
    }
}
//MARK: Search Bar
extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        switch dataDisplay {
        case .car:
            filteredCar = cars.filter { car in
                switch scope {
                case "0":
                    return car.model.localizedLowercase.contains(searchText.localizedLowercase)
                case "1":
                    return car.brand.localizedLowercase.contains(searchText.localizedLowercase)
                case "2":
                    return String(car.year).localizedLowercase.contains(searchText.localizedLowercase)
                default:
                    print("filer")
                    break
                }
            return true
            }
        case .events:
            filteredEvents = events.filter { event  in
                switch  scope {
                    case "0":
                        return event.name.localizedLowercase.contains(searchText.localizedLowercase)
                    case "1":
                        return event.cidade.localizedLowercase.contains(searchText.localizedLowercase)
                default:
                    break
                }
                return true
            }
        case .people:
            filteredPeople = peoples.filter { pe in
                return (pe.userName?.localizedLowercase.contains(searchText.localizedLowercase))!
            }
        }
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!, scope: searchController.searchBar.selectedScopeButtonIndex.description)
    }
}
//MARK: TABLEVIEW PROTOCOLS
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as! SearchTableViewCell
        
        switch dataDisplay {
        case .car:
            carData(cell: cell, row: indexPath.row)
        case .events:
            eventsData(cell: cell, row: indexPath.row)
        case .people:
            cell.delegate = self
            peopleData(cell: cell, row: indexPath.row)
        }
        return cell
    }
    //Search methods cell data
    fileprivate func carData(cell: SearchTableViewCell, row: Int) {
        let searchBar = searchController.isActive && searchController.searchBar.text != ""
        let image = searchBar ? filteredCar[row].thumbImage : cars[row].thumbImage
        
        cell.content.text = searchBar ? filteredCar[row].model : cars[row].model
        cell.subject.text = searchBar ? filteredCar[row].brand : cars[row].brand
        cell.year.text = searchBar ? String(filteredCar[row].year) : String(cars[row].year)
        
        loadImage(image: image, cell: cell)
    }
    
    fileprivate func eventsData(cell: SearchTableViewCell, row: Int) {
        let searchBar = searchController.isActive && searchController.searchBar.text != ""
        let image = searchBar ? filteredEvents[row].image : events[row].image
        
        cell.content.text = searchBar ? filteredEvents[row].name : events[row].name
        cell.subject.text = searchBar ? filteredEvents[row].eventDescription : events[row].eventDescription
        cell.year.text = searchBar ? filteredEvents[row].cidade : events[row].cidade
        
        loadImage(image: image, cell: cell)
    }
    
    fileprivate func peopleData(cell: SearchTableViewCell, row: Int) {
        let searchBar = searchController.isActive && searchController.searchBar.text != ""
        let image = searchBar ? filteredPeople[row].profilePhoto : peoples[row].profilePhoto
        
        cell.content.text = searchBar ? filteredPeople[row].userName : peoples[row].userName
        cell.subject.text = ""//searchBar ? filteredPeople[row]. : peoples[row].userName
        cell.year.text = ""//searchBar ? filteredPeople[row].userName : peoples[row].userName
        
        if image != nil {
            loadImage(image: image!, cell: cell)
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchTableViewCell.rowHeight
    }
    
    @objc(numberOfSectionsInTableView:) func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch dataDisplay {
        case .people:
            userSelected = searchController.isActive && searchController.searchBar.text != "" ? filteredPeople[indexPath.row] : peoples[indexPath.row]
            didTapToShowSeletedProfile()
        case .car:
            carSelected = searchController.isActive && searchController.searchBar.text != "" ? filteredCar[indexPath.row] : cars[indexPath.row]
            didTapToShowSeletedProfile()
        case .events:
            eventSelected = searchController.isActive && searchController.searchBar.text != "" ? filteredEvents[indexPath.row] : events[indexPath.row]
            ShowEventViewController.look = true
            didTapToShowSeletedProfile()
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dataDisplay {
        case .car:
            let countCar = searchController.isActive && searchController.searchBar.text != "" ? filteredCar.count : cars.count
            return countCar
        case .events:
            let countEvents = searchController.isActive && searchController.searchBar.text != "" ? filteredEvents.count : events.count
            return countEvents
        case .people:
            let countPeople = searchController.isActive && searchController.searchBar.text != "" ? filteredPeople.count : peoples.count
            return countPeople
        }
    }
}

extension SearchViewController: SearchTableViewDelegate {
    func didTapToShowSeletedProfile() {
        switch dataDisplay {
        case .people:
            let sb = UIStoryboard(name: "Show", bundle: Bundle.main)
            let vc = sb.instantiateViewController(withIdentifier: ShowProfileViewController.identifier)
            userShow = userSelected
            navigationController?.pushViewController(vc, animated: true)
        case .events:
            let sb = UIStoryboard(name: "Show", bundle: Bundle.main)
            let vc = sb.instantiateViewController(withIdentifier: ShowEventViewController.identifier)
            showEvent = eventSelected
            navigationController?.pushViewController(vc, animated: true)
        case .car:
            let sb = UIStoryboard(name: "Show", bundle: Bundle.main)
            let vc = sb.instantiateViewController(withIdentifier: ShowCarViewController.identifier)
            showCar = carSelected
            navigationController?.pushViewController(vc, animated: true)
        default:
            print("PAUUUUUU DID PROFILE")
        }
    }
}
