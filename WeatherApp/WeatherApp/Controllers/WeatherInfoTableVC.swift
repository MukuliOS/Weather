//
//  WeatherInfoTableVC.swift
//  WeatherApp
//
//  Created by Mukul Gupta on 12/16/20.
//

import UIKit

class WeatherInfoTableVC: UITableViewController {

    private var weatherInfoViewModel : WeatherInfoViewModel!
    var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cities"
        self.refreshControl?.addTarget(self, action: #selector(refreshPage), for: UIControl.Event.valueChanged)
        activityIndicatorView = UIActivityIndicatorView(style: .large)
        tableView.backgroundView = activityIndicatorView
        self.weatherInfoViewModel =  WeatherInfoViewModel()
        self.callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate(){
        self.activityIndicatorView.startAnimating()
        self.weatherInfoViewModel.reloadDelegate = self
        let joinedCitiesString = self.weatherInfoViewModel.cityIdArray.joined(separator: ",")
        self.weatherInfoViewModel.callFuncToGetCityWeatherData(cityIds:joinedCitiesString)
    }
    
    // MARK: - refresh Action
    
    @IBAction func refreshPage(sender: UIBarButtonItem) {
        self.callToViewModelForUIUpdate()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherInfoViewModel.getCitiesCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherinforeuseIdentifier", for: indexPath) as! WeatherInfoTableViewCell
        // Configure the cell...
        self.weatherInfoViewModel.updateProperties(index:indexPath.row)
        cell.templabel.text = self.weatherInfoViewModel.temperatureInDegress
        cell.cityNameLabel.text = self.weatherInfoViewModel.nameOfCity
        return cell
    }
    
    // MARK: - Table view Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
// MARK: - WeatherInfoDataReloadDelegate Methods

extension WeatherInfoTableVC: WeatherInfoDataReloadDelegate {
    func showAlertOnFailure(error:Error) {
        //Update UI on main thread
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            // show Alert on Failure
            self.openAlert(title: "Weather App",
                           message: error.localizedDescription,
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
    
    func reloadDataonSucess() {
        //Update UI on main thread
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            if (self.refreshControl?.isRefreshing == true) {
                self.refreshControl?.endRefreshing()
            }
            self.tableView.reloadData()
        }
    }
}



