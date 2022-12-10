//
//  WeatherTableViewCell.swift
//  WeatherForecast
//
//  Created by laputer on 11/19/22.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var Temperature: UILabel!
    
    @IBOutlet weak var forecast: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
