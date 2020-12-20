//
//  DetailInfoTableViewCell.swift
//  WeatherApp
//
//  Created by Mukul Gupta on 12/19/20.
//

import UIKit

class DetailInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var keyText: UILabel!
    @IBOutlet weak var KeyDesription: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    // reset the view
    func reset(){
        keyText?.text = nil
        KeyDesription?.text = nil
    }

}
