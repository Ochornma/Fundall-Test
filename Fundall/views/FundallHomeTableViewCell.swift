//
//  FundallHomeTableViewCell.swift
//  Fundall
//
//  Created by Promise Ochornma on 15/04/2021.
//

import UIKit

class FundallHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var progress: FundallProgress!
    @IBOutlet weak var item: UILabel!
    @IBOutlet weak var dailyPrice: UILabel!
    @IBOutlet weak var spendingStatus: UILabel!
    @IBOutlet weak var spentLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var tableCard: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup() {
        tableCard.layer.cornerRadius = 10
        statusImage.image = UIImage(named: "okay")
        itemImage.image = UIImage(named: "burger")
        progress.progress = 0.75
        item.text = "Lunch & Dinner"
        dailyPrice.text = "$52/day"
        spendingStatus.text = "Your food spending is still on track"
        spentLabel.text = "$450"
        budgetLabel.text = "$900"
    }

}
