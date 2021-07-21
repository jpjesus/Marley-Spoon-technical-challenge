//
//  UIView+Extension.swift
//  MarleySpoonChallenge
//
//  Created by Jesus Parada on 20/07/21.
//

import Foundation
import UIKit

// MARK: - Shadows and Corners
extension UIView {
    
    func setupRoundedCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func setupBorder(width: CGFloat = 1.0, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}
