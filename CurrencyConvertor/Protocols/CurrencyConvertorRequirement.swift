//
//  CurrencyConvertorRequirement.swift
//  CurrencyConvertor
//
//  Created by Navroz on 22/08/21.
//

import Foundation

protocol CurrencyConvertorRequirement {
    func updateWalletCard(amount: String, selectedCurrencyCount: Int)
    func reloadDataSource()
    func showAddCurrency(with viewModal: AddCurrencyViewModal)
}
