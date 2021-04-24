//
//  PostCommentsController.swift
//  PaginationDemo
//
//  Created by Muhammad Yousaf on 21/04/2021.
//

import UIKit

protocol PostCommentDataSource{
    func updateDataSource()
}

class PostCommentsController: ParentController,PostCommentDataSource {
   
    
    
    @IBOutlet weak var tblView: UITableView!
    private var isPaginating = false
    private var isDonePaginating = false
    private var postCommentVM : PostCommentsViewModel!
    var dataSource = PostCommentsDatasource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        getPublicComments()
    }
    
    private func registerCell() -> Void {
        tblView.register(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "LoadingCell")
    }
    
    private func getPublicComments(){
        
        postCommentVM = PostCommentsViewModel(dataSource: dataSource)
        dataSource.delegate = self
        showActivityIndicator()
        postCommentVM.onError = { [weak self] message in
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
        
        postCommentVM.getPostComments(offSet: Constant.shared.currentPageForComment)
        
    }
    
    func updateDataSource() {
        postCommentVM.getPostComments(offSet: Constant.shared.currentPageForComment)
    }
}

class PostCommentsDatasource: GenericDataSource<PostCommentsData>, UITableViewDataSource {
    
    
    
    var delegate:PostCommentDataSource?
    
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
            let cell = tableView.dequeue(PostCommentCell.self, for: indexPath)
            cell.comment = data.value[indexPath.row]
            
            if indexPath.item == data.value.count - 1 && Constant.shared.currentPageForComment < Constant.shared.totalPagesforComment {
                Constant.shared.currentPageForComment = Constant.shared.currentPageForComment + 1
                delegate?.updateDataSource()
            }
            return cell
        }else{
            let cell = tableView.dequeue(LoadingCell.self, for: indexPath)
            cell.activityIndicator.startAnimating()
            return cell
        }
    }
    
}


