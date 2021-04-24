//
//  ProfileCell.swift
//  PaginationDemo
//
//  Created by Muhammad Yousaf on 21/04/2021.
//

import UIKit

protocol postsCellDelegate{
    func didTapHeaderView(userId:Int)
    func didTapPostView()
}
class ProfileCell: UITableViewCell {

    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var postView: UIView!
    var postCellDelegate:postsCellDelegate?
    
    var selectedIndex:Int = 0
    var userId:Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImgView.layer.cornerRadius = profileImgView.frame.size.width/2
        profileImgView.clipsToBounds = true
        profileImgView.isUserInteractionEnabled = true
        userNameLabel.isUserInteractionEnabled = true
        let postTap = UITapGestureRecognizer(target: self, action: #selector(self.openPostCommentsScreen))
        postView.addGestureRecognizer(postTap)
        
        let headerTap = UITapGestureRecognizer(target: self, action: #selector(self.openProfileScreen))
        headerView.addGestureRecognizer(headerTap)

    }
    var post : UserPostsData? {
           didSet {
              titleLabel.text = post?.title
              bodyLabel.text = post?.body
           }
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @objc func openProfileScreen(_ sender:UITapGestureRecognizer){
        postCellDelegate?.didTapHeaderView(userId: userId)
        
       }
    @objc func openPostCommentsScreen(){
        postCellDelegate?.didTapPostView()
       }

}
