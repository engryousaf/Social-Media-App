//
//  PostCommentCell.swift
//  PaginationDemo
//
//  Created by Muhammad Yousaf on 21/04/2021.
//

import UIKit

class PostCommentCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var comment : PostCommentsData? {
           didSet {
             
            nameLabel.text = "Name: \(comment?.name ?? "")"
            emailLabel.text = "Email: \(comment?.email ?? "")"
            bodyLabel.text = "Body: \(comment?.body ?? "")"
            createdAtLabel.text = "Created at: \(comment?.created_at ?? "")"
            updatedAtLabel.text = "Updated at: \(comment?.updated_at ?? "")"
           }
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
