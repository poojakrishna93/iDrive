//
//  NSObjectExtension.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/11/21.
//

import Foundation

extension NSObject {

    /// Returns class name string
    var className: String {
        return String(describing: type(of: self))
    }

    class var className: String {
        return String(describing: self)
    }
}
