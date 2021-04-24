//
//  PublicCommentsViewModel.swift
//  PaginationDemo
//
//  Created by Muhammad Yousaf on 23/04/2021.
//

import UIKit
import Foundation

class PostCommentsViewModel {

    
    var dataSource: GenericDataSource<PostCommentsData>
    var onError: ((String) -> ())?
    
    var errorMessage: String = "" {
        didSet {
            onError?(errorMessage)
        }
    }
    init(dataSource: GenericDataSource<PostCommentsData>) {
        self.dataSource = dataSource
    }
    
    func getPostComments(offSet:Int){
       
        if Reachability.isConnectedToNetwork(){
            
            let url = AssignmentURL.getPostComments + "?limit=\(Constant.shared.limit)?offset=\(offSet)"
            Service.shared.getPublicComments(url: URL(string: url)!) { (data, error) in
                if let error = error
                {
                    self.errorMessage = error.localizedDescription
                    return
                }
                guard let data = data else {return}
                do{
                   let response = try JSONDecoder().decode(PostComments.self, from: data)
                    if(response.code == 200){
                        
                        Constant.shared.currentPageForComment = response.meta?.pagination?.page ?? 0
                        Constant.shared.totalPagesforComment = response.meta?.pagination?.pages ?? 0
                        
                        self.dataSource.data.value += response.data!
                    }else{
                        self.errorMessage = Constant.shared.somethingWent
                    }
                   
                }catch{
                    self.errorMessage = error.localizedDescription
                }
            }
        }else{
            self.errorMessage = Constant.shared.noInternet
        }
    }
    
    
//    func getPublicComments(offSet:Int,success:@escaping ((_ profile:PublicPostComments)->Void), failure:@escaping ((_ msg:String)->Void)){
//
//        if Reachability.isConnectedToNetwork(){
//
//            let url = AssignmentURL.getPostComments + "?limit=\(Constant.shared.limit)?offset=\(offSet)"
//            Service.shared.getPublicComments(url: URL(string: url)!) { (data, error) in
//                if let error = error
//                {
//                    print(error.localizedDescription)
//                    failure(error.localizedDescription)
//                    return
//                }
//                guard let data = data else {return}
//                do{
//                   let response = try JSONDecoder().decode(PublicPostComments.self, from: data)
//                    if(response.code == 200){
//                       success(response)
//                    }else{
//                        failure(Constant.shared.somethingWent)
//                    }
//
//                }catch{
//                    failure(error.localizedDescription)
//                }
//            }
//        }else{
//            failure(Constant.shared.noInternet)
//        }
//    }

}

