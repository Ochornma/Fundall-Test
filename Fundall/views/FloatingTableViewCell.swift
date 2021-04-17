//
//  FloatingTableViewCell.swift
//  Fundall
//
//  Created by Promise Ochornma on 17/04/2021.
//

import UIKit

class FloatingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var priceText: UILabel!
    @IBOutlet weak var mainText: UILabel!
    @IBOutlet weak var subText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
