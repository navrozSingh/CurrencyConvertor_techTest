//
//  UIView+Extensions.swift
//  CurrencyConvertor
//
//  Created by Navroz on 21/08/21.
//

import UIKit

extension UIView {
    
    func addShadow(
        ofColor color: UIColor = .gray,
        radius: CGFloat = 3,
        offset: CGSize = .zero,
        opacity: Float = 0.5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
}
