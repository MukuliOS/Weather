//
//  WeatherInfoTableViewCell.swift
//  WeatherApp
//
//  Created by Mukul Gupta on 12/16/20.
//

import UIKit

class WeatherInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var templabel: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    // reset the view
    func reset(){
        cityNameLabel?.text = nil
        templabel?.text = nil
    }

}
