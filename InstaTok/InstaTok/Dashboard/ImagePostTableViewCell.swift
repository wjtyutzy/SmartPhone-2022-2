//
//  ImagePostTableViewCell.swift
//  InstaTok
//
//  Created by laputer on 11/18/22.
//

import UIKit

class ImagePostTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    
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
