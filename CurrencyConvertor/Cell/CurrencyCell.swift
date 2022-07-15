//
//  CurrencyCell.swift
//  CurrencyConvertor
//
//  Created by Navroz on 21/08/21.
//

import UIKit
import Foundation

class CurrencyCell: UITableViewCell {
    private enum Constant {
        static let amountFont = UIFont.preferredFont(forTextStyle: .largeTitle)
        static let padding: CGFloat = 16
    }
    
    private let amountLabel = UILabel.createLabel(with: Constant.amountFont, alignment: .center)
     
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    func configureCell(with modal: CurrencyModal) {
        amountLabel.text =  modal.amountForCell()
    }

}
private extension CurrencyCell {
    
    func setupUI() {
        
        contentView.addSubview(amountLabel)
        amountLabel.addShadow()
        NSLayoutConstraint.activate([
            amountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constant.padding),
            amountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constant.padding),
            amountLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constant.padding),
            amountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constant.padding),
        ])
    }
}
