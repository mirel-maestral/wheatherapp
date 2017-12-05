//
//  ForeCastCell.swift
//  wheatherapp
//
//  Created by Mirel Spahić on 12/4/17.
//  Copyright © 2017 Mirel Spahić. All rights reserved.
//

import UIKit

class ForeCastCell: UITableViewCell {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var day: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
