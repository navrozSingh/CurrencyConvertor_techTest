//
//  UILabel+Extension.swift
//  CurrencyConvertor
//
//  Created by Navroz on 21/08/21.
//

import UIKit

extension UILabel {
    static func createLabel(with font: UIFont, text: String? = nil, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.font = font
        label.text = text
        label.backgroundColor = .white
        label.textAlignment = alignment
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

extension UIButton {
    static func createButton(with title: String) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .black
        return btn
    }
}

extension UITextField {
    
    static func createTextField(with placeholder: String) -> UITextField {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.heightAnchor.constraint(equalToConstant: 50).isActive = true
        txt.borderStyle = .roundedRect
        txt.placeholder = placeholder
        return txt
    }
}
