//
//  SelectedCurrenyModal.swift
//  CurrencyConvertor
//
//  Created by Navroz on 22/08/21.
//

import Foundation

class CurrencyModal {
    let id = UUID()
    var currency: String?
    var amount: String?
    var flag: String?
    var CADConversion: Double?
}

extension CurrencyModal {
    func amountForCell() -> String {
        return flag.unwrapped(or: "") + " " + amount.unwrapped(or: "") + " " + currency.unwrapped(or: "")
    }
    
    func totalAmount() -> Double? {
        guard let amount = amount?.removeCurrencySymbols().doubleValue,
              let CADConversion = CADConversion
        else { return nil }
              
              
        return amount * CADConversion
    }
}

extension CurrencyModal: Equatable {
    static func ==(lhs: CurrencyModal, rhs: CurrencyModal) -> Bool {
        lhs.id == rhs.id
    }
}
