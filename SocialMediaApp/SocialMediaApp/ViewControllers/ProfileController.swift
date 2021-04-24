//
//  ProfileController.swift
//  PaginationDemo
//
//  Created by Muhammad Yousaf on 21/04/2021.
//

import UIKit

class ProfileController: ParentController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var profileImgView: UIImageView!
    public var userId:Int = 0
    private var profileVM : ProfileViewModel!
    //private var profileDetails = [ProfileDetails]()
    var dataSource = ProfileDatasource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userId)
        setUpUI()
        loadUserProfile()
    }
    private func setUpUI() -> Void {
        profileImgCircle(imgView: profileImgView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func loadUserProfile(){
        profileVM = ProfileViewModel(dataSource: dataSource)
        
        showActivityIndicator()
        profileVM.onError = { [weak self] message in
            DispatchQueue.main.async {
                self?.hideActivityIndicator()
                self?.alert(title: "", message: message)
            }
        }
        
        tblView.dataSource = dataSource
        dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            DispatchQueue.main.async {
                self?.hideActivityIndicator()
                self?.tblView.reloadData()
            }
        }
        
        profileVM.getUserProfile(userId: userId)
        
    }
}


class ProfileDatasource: GenericDataSource<ProfileDetails>, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(UserProfileDetailCell.self, for: indexPath)
        cell.profile = data.value[indexPath.row]
        return cell
    }
}

