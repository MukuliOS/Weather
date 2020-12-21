//
//  AddLocationTableVC.swift
//  WeatherApp
//
//  Created by Mukul Gupta on 12/20/20.
//

import UIKit

protocol AddWeatherDelegate:class {
    func addLocation(location:String)->Bool
}

class AddLocationTableVC: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate, AddLocationCellDelegate {
    
    weak var delegate: AddWeatherDelegate?
    private var addLocationViewModel : AddLocationViewModel!
    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Add Location"
        addLocationViewModel = AddLocationViewModel()
        addLocationViewModel.getCitiesFromLocalJSonFile()
        self.setupSearchBar()
    }
    
    func setupSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Enter Location"
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addLocationViewModel.getFilteredCitiesCount()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! AddLocationTableViewCell
        cell.delegate = self
        cell.addLocationBtn.tag = indexPath.row
        // Configure the cell...
        self.addLocationViewModel.updateRecords(index: indexPath.row)
        cell.locationName.text = self.addLocationViewModel.nameOfCity
        return cell
    }
    
    // MARK: - SearchController Delegate

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            addLocationViewModel.filterListOfCities(locationName: searchText)
                tableView.reloadData()
            }
    }
    
        
    // MARK: - Action Methods

    @IBAction func didTapLocationButton(_ sender: UIButton) {
        self.addLocationViewModel.updateRecords(index: sender.tag)
        //call delegate and check city values if already present
        let added = delegate?.addLocation(location:self.addLocationViewModel.cityId)
        if added == true{
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
        else {
            //already added
            self.searchController.isActive = false
            self.openAlert(title: "Weather App",
                           message: "Already added in list.",
                           alertStyle: .alert,
                           actionTitles: ["Ok"],
                           actionStyles: [.default],
                           actions: [
                            {_ in
                                print("okay clicked")
                            }
                           ])
        }
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
