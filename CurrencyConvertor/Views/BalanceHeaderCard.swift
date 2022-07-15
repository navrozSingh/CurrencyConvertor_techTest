//
//  BalanceHeaderCard.swift
//  CurrencyConvertor
//
//  Created by Navroz on 21/08/21.
//

import UIKit
import Foundation

class BalanceHeaderCard: UIView {
    
    private enum Constant {
        static let containerHeight: CGFloat = UIScreen.main.bounds.width / 2
        static let labelHeight: CGFloat = 32
        static let totalBalanceFont = UIFont.preferredFont(forTextStyle: .headline)
        static let currenciesLabelFont = UIFont.preferredFont(forTextStyle: .body)
        static let amountFont = UIFont.preferredFont(forTextStyle: .largeTitle)
        static let padding: CGFloat = 16
        static let infoMessage = "Please select a currency"
        static let totalBalance = "Total Balance"
        static let noCurrencies = "No currency selected"
        static let currencies = " currencies selected"

    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private lazy var totalBalance = UILabel.createLabel(with: Constant.totalBalanceFont,
                                                        text: "",
                                                        alignment: .left)
    private lazy var amountLabel = UILabel.createLabel(with: Constant.amountFont,
                                                       alignment: .center)
    private lazy var currenciesLabel = UILabel.createLabel(with: Constant.currenciesLabelFont,
                                                           text: Constant.noCurrencies,
                                                           alignment: .left)
    private lazy var currenciesLabelHeight = currenciesLabel.heightAnchor.constraint(equalToConstant: 0)
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = Constant.padding
        containerView.addShadow()
        return containerView
    }()
    
    func configure(with text: String, totalSelectedCurrency: Int) {
        amountLabel.text = text.isEmpty ? Constant.infoMessage : text
        let currenciesTxt = totalSelectedCurrency == 0 ? Constant.noCurrencies : String(totalSelectedCurrency) + Constant.currencies
        currenciesLabel.text = currenciesTxt
        currenciesLabelHeight.constant = Constant.labelHeight
    }
}

private extension BalanceHeaderCard {
    func setupUI() {
        self.backgroundColor = .white
        addSubview(containerView)
        addSubview(currenciesLabel)
        containerView.addSubview(totalBalance)
        containerView.addSubview(amountLabel)
        activateContraints()
        //To shadow at the bottom
        bringSubviewToFront(containerView)
        
    }
    
        
    func activateContraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constant.padding),
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constant.padding),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constant.padding),
            containerView.heightAnchor.constraint(equalToConstant: Constant.containerHeight),

            currenciesLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            currenciesLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            currenciesLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            currenciesLabelHeight,
            currenciesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            totalBalance.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constant.padding),
            totalBalance.topAnchor.constraint(equalTo: containerView.topAnchor),
            totalBalance.heightAnchor.constraint(equalToConstant: Constant.labelHeight),
            
            amountLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            amountLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            amountLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)

        ])
    }
}
