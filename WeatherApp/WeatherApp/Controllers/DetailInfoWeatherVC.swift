//
//  DetailInfoWeatherVCTableViewController.swift
//  WeatherApp
//
//  Created by Mukul Gupta on 12/19/20.
//

import UIKit

class DetailInfoWeatherVC: UITableViewController {

    var detailInfoViewModel : DetailInfoViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailInfoViewModel.updateProperties()
        self.title = self.detailInfoViewModel.cityName
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! DetailInfoTableViewCell
        // Configure the cell...
        switch indexPath.row {
        case 0:
            cell.keyText.text = "MaxTemp"
            cell.KeyDesription.text = self.detailInfoViewModel.temperatureMax
            break
        case 1:
            cell.keyText.text = "MinTemp"
            cell.KeyDesription.text = self.detailInfoViewModel.temperatureMin
            break
        case 2:
            cell.keyText.text = "FeelsLike"
            cell.KeyDesription.text = self.detailInfoViewModel.feelsLike
            break
        case 3:
            cell.keyText.text = "humidity"
            cell.KeyDesription.text = self.detailInfoViewModel.humidity
            break
        case 4:
            cell.keyText.text = "Weather"
            cell.KeyDesription.text = self.detailInfoViewModel.weather
            break
        default:
            fatalError("Error")
        }

        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // wave animation here
        cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
        UIView.animate(withDuration: 2, delay: 0.05 * Double(indexPath.row), usingSpringWithDamping: 0.7, initialSpringVelocity: 0.2, options: .curveEaseIn, animations: {
              cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
        })
    }
}
