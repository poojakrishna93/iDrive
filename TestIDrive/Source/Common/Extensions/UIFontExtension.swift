//
//  UIFontExtension.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/9/21.
//

import UIKit

enum FontSize {
    static let size_20: CGFloat = 20
    static let size_18: CGFloat = 18
    static let size_16: CGFloat = 16
    static let size_14: CGFloat = 14
}

extension UIFont {
    class func customStyle_H1() -> UIFont {
        return boldSystemFont(ofSize: FontSize.size_20)
    }

    /**
     Bold-18
     */
    class func customStyle_H2() -> UIFont {
        return boldSystemFont(ofSize: FontSize.size_18)
    }

    class func customStyle_H3() -> UIFont {
        return boldSystemFont(ofSize: FontSize.size_16)
    }
    
    class func customStyle_H4() -> UIFont {
        return systemFont(ofSize: FontSize.size_18)
    }
    
    class func customStyle_H5() -> UIFont {
        return systemFont(ofSize: FontSize.size_16)
    }
    
    class func customStyle_H6() -> UIFont {
        return systemFont(ofSize: FontSize.size_14)
    }
    
}
