//
//  UserProfileDetailCell.swift
//  PaginationDemo
//
//  Created by Muhammad Yousaf on 23/04/2021.
//

import UIKit

class UserProfileDetailCell: UITableViewCell {

    @IBOutlet weak var valueParentView: UIView!
    @IBOutlet weak var valueNameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        valueParentView.layer.cornerRadius = 10.0
        valueParentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        valueParentView.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        valueParentView.layer.shadowOpacity = 1.0
        valueParentView.layer.shadowRadius = 0.0
        valueParentView.layer.masksToBounds = false
        valueParentView.layer.cornerRadius = 10.0
    }
    var profile : ProfileDetails? {
           didSet {
              valueNameLabel.text = profile?.title
              valueLabel.text = profile?.value
           }
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   

}
