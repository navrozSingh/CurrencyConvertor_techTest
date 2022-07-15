//
//  FetchAllCurrencies.swift
//  CurrencyConvertor
//
//  Created by Navroz on 21/08/21.
//

import Foundation
import Combine
import Apollo

class FetchAllCurrencies {
    let publisher = PassthroughSubject<[AllCurreniesModal], Error>()
    func fetch() {
        Network.shared.apollo.fetch(query: AllCurrenciesQuery()) { [weak self] result in
            switch result {
            case .success(let response):
                let allCurrencies = response.data?.latest.compactMap { [weak self] in
                    self?.mapper(currency: $0.quoteCurrency, quote: $0.quote)
                }
                guard let currencyList = allCurrencies
                else {
                    return // throw error
                }
                self?.publisher.send(currencyList)
            case .failure(let error):
                self?.publisher.send(completion: .failure(error))
            }
        }
    }
    
    private func mapper(currency: String, quote: String) -> AllCurreniesModal? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let quote = formatter.number(from: quote)
        else { return nil }
        return AllCurreniesModal(currency: currency,
                                 conversionFromEur: quote)

    }
}

