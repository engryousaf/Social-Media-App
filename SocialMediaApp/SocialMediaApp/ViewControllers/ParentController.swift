//
//  ParentController.swift
//  SocialMediaApp
//
//  Created by PureLogics on 24/04/2021.
//

import UIKit

class ParentController: UIViewController {
    var activityView: UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func cornerRadius(view:UIView) -> Void {
        view.layer.cornerRadius = 10.0
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 0.0
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10.0
    
    }
    func profileImgCircle(imgView:UIImageView) -> Void {
        imgView.layer.cornerRadius = imgView.frame.size.width/2
        imgView.layer.borderWidth = 1.0
        imgView.layer.borderColor = UIColor.lightGray.cgColor
        imgView.clipsToBounds = true
    }
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }

    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
            activityView?.isHidden = true
        }
    }
}
