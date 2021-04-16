//
//  FundallCardTableViewCell.swift
//  Fundall
//
//  Created by Promise Ochornma on 15/04/2021.
//

import UIKit

class FundallCardTableViewCell: UITableViewCell {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var mainText: UILabel!
    @IBOutlet weak var subText: UILabel!
    
    //Handles the cell selected state
    var checked: Bool! {
        didSet {
            if (self.checked == true) {
                self.checkImage.isHidden = false
            }else{
                self.checkImage.isHidden = true
            }
        }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        checked = false
        self.layoutMargins = UIEdgeInsets.zero
        self.separatorInset = UIEdgeInsets.zero
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp() {
        self.mainText?.text = "Lifestyle Pro"
        self.subText?.text = "₦  9500"
        self.mainImage?.backgroundColor = .gray
        self.mainImage?.layer.cornerRadius = 20
        self.checkImage?.isHidden = true
        
    }
    
    func reloadForIndicator(){
        self.mainText?.text = "Lifestyle Pro"
        self.subText?.text = "₦  9500"
        self.mainImage?.backgroundColor = .gray
        self.mainImage?.layer.cornerRadius = 20
        self.checkImage?.isHidden = false
    }

}
