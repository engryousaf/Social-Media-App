//
//  AssignmentURL.swift
//  PaginationDemo
//
//  Created by Muhammad Yousaf on 23/04/2021.
//

import Foundation

struct AssignmentURL {
    
    private struct Domain {
        
      static let domainUrl =  "https://gorest.co.in"
    
    }
    private struct Routes {
        static let apiRoute = "/public-api/"
    }
    private static let domain = Domain.domainUrl
    private static let baseUrl = domain + Routes.apiRoute
    static let getPublicPosts:String = baseUrl + "posts"
    static let getPostComments:String = baseUrl + "comments"
    static let getUserProfile:String = baseUrl + "users/"
    
    
}
