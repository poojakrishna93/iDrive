//
//  UIColorExtension.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/9/21.
//

import UIKit

extension UIColor {
    /*Convinience method for hex to rgb values.
     @param rgb: hex value
     */
    private convenience init(rgb: UInt) {
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
    }

    // Color palette colors

    static var iDrivePrimary: UIColor { return UIColor(rgb: 0xE71346) }
    static var iDriveLightGray: UIColor { return UIColor(rgb: 0xF2F2F2) }
    static var iDriveTextGray: UIColor { return UIColor(rgb: 0xCCCCCC) }
    static var iDriveWhite: UIColor { return UIColor(rgb: 0xFFFFFF) }
    static var iDriveBlack: UIColor { return UIColor(rgb: 0x000000) }
}
