//
//  UITableView.swift
//  PaginationDemo
//
//  Created by Muhammad Yousaf on 23/04/2021.
//

import Foundation
import UIKit
extension UITableView {
    
   
    func register<T: UITableViewCell>(_: T.Type) where T: ResuableViews {
            self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier )
        }
    
    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self),
                                           for: indexPath) as? T
            else { fatalError("Could not deque cell with type \(T.self)") }
        return cell
    }
    
    
    
    func dequeueCell(reuseIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath
        )
    }
}
