//
//  UIViewExtension.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/9/21.
//

import UIKit

extension UIView {
    
    /**
     Method to apply shadow
     @param cornerRadius: corder raadius for the view
     @param color: color of shadow
     @param opacity:  shadoe opacity
     @param shadowRadius: radius of shadow
     */
    func applyShadow(cornerRadius: CGFloat = 4.0, color: UIColor = UIColor.black, opacity: Float = 0.1, shadowRadius: CGFloat = 4.0) {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = color.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = CGSize(width: -0.05, height: -0.05)
    }
}
