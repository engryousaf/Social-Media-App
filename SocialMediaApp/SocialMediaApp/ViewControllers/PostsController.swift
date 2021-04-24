//
//  ViewController.swift
//  SocialMediaApp
//
//  Created by PureLogics on 24/04/2021.
//

import UIKit

protocol PostDataSourceDelegate{
    func updateDataSource()
    func tapHeaderView(userId:Int)
    func tapPostView()
}
class ViewController: ParentController, PostDataSourceDelegate {
    
   
    
    @IBOutlet weak var tblView: UITableView!
    private var isPaginating = false
    private var isDonePaginating = false
    private var postsVM : PostsViewModel!
    var dataSource = PostsDatasource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registeCell()
        getPosts()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
   private func registeCell() -> Void {
        tblView.register(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "LoadingCell")
    }

    private func getPosts(){
        
        postsVM = PostsViewModel(dataSource: dataSource)
        dataSource.delegate = self
        showActivityIndicator()
        postsVM.onError = { [weak self] message in
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
        
        postsVM.getPosts(offSet: Constant.shared.currentPageForPost)
        
    }
    
    // Custom delegate methods
    
    func tapHeaderView(userId: Int) {
        let profileVC = self.storyboard?.instantiateViewController(identifier: "ProfileController") as! ProfileController
        profileVC.userId = userId
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func tapPostView() {
        let profileVC = self.storyboard?.instantiateViewController(identifier: "PostCommentsController") as! PostCommentsController
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func updateDataSource() {
        postsVM.getPosts(offSet: Constant.shared.currentPageForPost)
    }
    
}

class PostsDatasource: GenericDataSource<UserPostsData>, UITableViewDataSource, postsCellDelegate {
    
    
    private var isPaginating = false
    private var isDonePaginating = false
    var delegate:PostDataSourceDelegate?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return data.value.count
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeue(ProfileCell.self, for: indexPath)
            cell.post = data.value[indexPath.row]
            cell.userId = data.value[indexPath.row].user_id
            cell.postCellDelegate = self
            
            if indexPath.item == data.value.count - 1 && Constant.shared.currentPageForPost < Constant.shared.totalPagesforPost {
                Constant.shared.currentPageForPost = Constant.shared.currentPageForPost + 1
                delegate?.updateDataSource()
            }
            return cell
        }else{
            let cell = tableView.dequeue(LoadingCell.self, for: indexPath)
            cell.activityIndicator.startAnimating()
            return cell
        }
    }
    
    func didTapHeaderView(userId: Int) {
        delegate?.tapHeaderView(userId:userId)
    }
    
    func didTapPostView() {
        delegate?.tapPostView()
    }
}

