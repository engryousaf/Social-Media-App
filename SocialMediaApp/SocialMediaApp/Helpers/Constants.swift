//
//  Constants.swift
//  PaginationDemo
//
//  Created by Muhammad Yousaf on 23/04/2021.
//

import Foundation
class Constant:NSObject {
    
    static let shared = Constant()
    public var totalPagesforPost = 0
    public var currentPageForPost = 1
    
    public var totalPagesforComment = 0
    public var currentPageForComment = 1
    
    public var limit = 20
    
    let noInternet = "Please make sure your device is connected to the Internet."
    let somethingWent = "Something went wrong. Please try again later."
    
   
}
