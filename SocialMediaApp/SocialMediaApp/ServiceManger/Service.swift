

//
//  Service.swift
//  AssignmentDemo
//
//  Created by Yousaf on 30/04/2019.
//  Copyright © 2019 Yousaf. All rights reserved.
//

import Foundation

class Service
{
    static let shared = Service()
    
    func getPublicPosts(url:URL,competion:@escaping (Data?,Error?) -> ())  {
        
        self.requestService(url: url) { (data, error) in
            if let error = error
            {
                competion(nil,error)
                return
            }
            competion(data,nil)
        }
    }
    func getPublicComments(url:URL,competion:@escaping (Data?,Error?) -> ())  {
        
        self.requestService(url: url) { (data, error) in
            if let error = error
            {
                competion(nil,error)
                return
            }
            competion(data,nil)
        }
    }
    func getUserProfile(url:URL,competion:@escaping (Data?,Error?) -> ())  {
    
        self.requestService(url: url) { (data, error) in
            if let error = error
            {
                competion(nil,error)
                return
            }
            competion(data,nil)
        }
    }
    
    func requestService(url:URL,competion:@escaping (Data?,Error?) -> ()){
        
        URLSession.shared.dataTask(with: url) { (data, res, error) in
            
            if let error = error
            {
                competion(nil,error)
                return
            }
            competion(data,nil)
            
        }.resume()
    }
   
}
