//
//  AddLocationTableViewCell.swift
//  WeatherApp
//
//  Created by Mukul Gupta on 12/20/20.
//

import UIKit

protocol AddLocationCellDelegate: class {
    func didTapLocationButton(_ sender: UIButton)
}

class AddLocationTableViewCell: UITableViewCell {

    weak var delegate: AddLocationCellDelegate?

    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var addLocationBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    // reset the view
    func reset(){
        locationName.text = nil
    }
    
}
