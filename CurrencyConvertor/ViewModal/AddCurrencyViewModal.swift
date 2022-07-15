//
//  AddCurrencyViewModal.swift
//  CurrencyConvertor
//
//  Created by Navroz on 22/08/21.
//

import Foundation
import Combine

class AddCurrencyViewModal {
    let currencyList: [AllCurreniesModal]
    private(set) var selectedModal: CurrencyModal
    let publisher = PassthroughSubject<CurrencyModal, Never>()
    var requirement: AddCurrencyRequirement?
    
    init(currencyList: [AllCurreniesModal],
         selectedModal: CurrencyModal) {
        self.currencyList = currencyList
        self.selectedModal = selectedModal
    }
        
    func save(with currency: String?, amount: String?) {
        
        guard
            let currency = currency,
            let amount = amount,
            !currency.isEmpty,
              !amount.isEmpty else {
            return // throw error
        }

        selectedModal.amount = amount
        selectedModal.currency = currency
        selectedModal.flag = flag(for: currency)
        publisher.send(selectedModal)
        requirement?.dismiss()
        
    }
    
    func flag(for currencyCode: String) -> String? {
        let localeIds = Locale.availableIdentifiers
        for localeId in localeIds {
            let locale = Locale(identifier: localeId)
            
            if locale.currencyCode == currencyCode,
               let code = locale.regionCode {
                
                return code
                    .unicodeScalars
                    .map({ 127397 + $0.value })
                    .compactMap(UnicodeScalar.init)
                    .map(String.init)
                    .joined()
            }
            
        }
        return nil
    }
}
