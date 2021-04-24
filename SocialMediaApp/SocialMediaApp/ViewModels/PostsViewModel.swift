//
//  PublicPostsViewModel.swift
//  PaginationDemo
//
//  Created by Muhammad Yousaf on 23/04/2021.
//

import UIKit
import Foundation

class PostsViewModel {

    
    var dataSource: GenericDataSource<UserPostsData>
    var onError: ((String) -> ())?
    
    var errorMessage: String = "" {
        didSet {
            onError?(errorMessage)
        }
    }
    init(dataSource: GenericDataSource<UserPostsData>) {
        self.dataSource = dataSource
    }
    
    func getPosts(offSet:Int){
       
        if Reachability.isConnectedToNetwork(){
            let url = AssignmentURL.getPublicPosts + "?limit=\(Constant.shared.limit)?offset=\(offSet)"
            Service.shared.getPublicPosts(url: URL(string: url)!) { (data, error) in
                if let error = error
                {
                    self.errorMessage = error.localizedDescription
                    return
                }
                guard let data = data else {return}
                do{
                   let response = try JSONDecoder().decode(Posts.self, from: data)
                    if(response.code == 200){
                    
                        let sortedData = self.sortData(data: response.data!)
                        Constant.shared.currentPageForPost = response.meta?.pagination?.page ?? 0
                        Constant.shared.totalPagesforPost = response.meta?.pagination?.pages ?? 0
                        self.dataSource.data.value += sortedData
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
    
    func sortData(data:[PostsData]) ->[UserPostsData]{
        
        var userPostsArray = [UserPostsData]()
        userPostsArray.removeAll()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        for post in data{
            let date = dateFormatter.date(from: post.updated_at ?? "") ?? Date()
            userPostsArray.append(UserPostsData(id: post.id ?? 0, user_id: post.user_id ?? 0, title: post.title ?? "", body: post.body ?? "", created_at: post.created_at ?? "", updated_at: date))
        }
       
        userPostsArray = userPostsArray.sorted(by: { $0.updated_at > $1.updated_at })

        return userPostsArray
    }
    

}

struct UserPostsData {
    let id : Int
    let user_id : Int
    let title : String
    let body : String
    let created_at : String
    let updated_at : Date
    
    init(id:Int,user_id:Int,title:String,body:String,created_at:String,updated_at:Date) {
        self.id = id
        self.user_id = user_id
        self.title = title
        self.body = body
        self.created_at = created_at
        self.updated_at = updated_at
    }

}
