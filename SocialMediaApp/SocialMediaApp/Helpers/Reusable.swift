//
//  Reusable.swift
//  PaginationDemo
//
//  Created by Muhammad Yousaf on 23/04/2021.
//

import Foundation
import UIKit


protocol ResuableViews {
    static var reuseIdentifier: String { get }
}

extension ResuableViews where Self: UIView {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}


protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
