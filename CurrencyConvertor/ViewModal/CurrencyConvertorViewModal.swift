//
//  CurrencyConvertorViewModal.swift
//  CurrencyConvertor
//
//  Created by Navroz on 21/08/21.
//

import Foundation
import Combine
import Apollo

class CurrencyConvertorViewModal {
    private let allCurrenciesRoute: FetchAllCurrencies
    private var allCurrencies: [AllCurreniesModal]?
    private(set) var dataSource: [CurrencyModal]
    var requirement: CurrencyConvertorRequirement?
    private var bag = Set<AnyCancellable>()

    init(allCurrenciesRoute: FetchAllCurrencies = .init(),
         dataSource: [CurrencyModal] = .init(),
         allCurrencies: [AllCurreniesModal]? = nil) {
        self.allCurrenciesRoute = allCurrenciesRoute
        self.dataSource = dataSource
        self.allCurrencies = allCurrencies
    }
    
    func getAllCurrencies() {
        guard let currencyList = allCurrencies,
              !currencyList.isEmpty
        else {
            fetchFromApi()
            return
        }
        showCurrency(currencyList)
    }
    
    func deleteDataSourceAt(_ index: Int) {
        dataSource.remove(at: index)
        requirement?.updateWalletCard(amount: totalAmountForCard(),
                                  selectedCurrencyCount: dataSource.count)
    }

    func editDataSourceAt(_ Index: Int) {
        guard let currencyList = allCurrencies
        else { return }
            
        showCurrency(currencyList, dataSource[Index])
    }
    
    func showCurrency(_ currencyList: [AllCurreniesModal], _ modal: CurrencyModal = .init()) {
        let addCurrencyViewModal = AddCurrencyViewModal(currencyList: currencyList,
                                                        selectedModal: modal)
        addCurrencyViewModal.publisher.sink { [weak self] (selectedModal) in
            self?.updateDataSource(with: selectedModal)
        }.store(in: &bag)
        requirement?.showAddCurrency(with: addCurrencyViewModal)
    }
}


private extension CurrencyConvertorViewModal {
    
    func fetchFromApi() {
        allCurrenciesRoute.publisher.sink { (result) in
            guard case let .failure(error) = result
            else { return }
            print(error)
        } receiveValue: { [weak self] (response) in
            self?.handleResponse(response)
        }.store(in: &bag)
        
        allCurrenciesRoute.fetch()
    }
    
    func handleResponse(_ response: [AllCurreniesModal]) {
        allCurrencies = response
        showCurrency(response)
    }
    
    func updateDataSource(with modal: CurrencyModal) {
        defer {
            modal.CADConversion = cadCalculation(for: modal)
            requirement?.updateWalletCard(amount: totalAmountForCard(),
                                          selectedCurrencyCount: dataSource.count)
            requirement?.reloadDataSource()
        }
        guard let indexToUpdate = dataSource.firstIndex(of: modal)
        else {
            dataSource.append(modal)
            return
        }
        dataSource[indexToUpdate] = modal
        
    }
    
    func totalAmountForCard() -> String {
        let zero = Double(0)
        let totalAmount = dataSource.reduce(zero) { (result, modal)  in
            (modal.totalAmount() ?? zero) + result
        }
        guard totalAmount > zero else {
            return ""
        }
        return totalAmount.currencyInputFormatting() + " CAD"
    }
    
    func cadCalculation(for currencyModal: CurrencyModal) -> Double {
        
        let eurToCadModal = allCurrencies?.first(where: { (modal) -> Bool in
            modal.currency == "CAD"
        })
        let currencyToFindModal = allCurrencies?.first(where: { (modal) -> Bool in
            modal.currency == currencyModal.currency
        })
        
        guard let eurToCad = eurToCadModal,
              let currencyToFind = currencyToFindModal
        else {
            preconditionFailure("Unable to find base currency to CAD rates")
        }
        let oneCadToCurrency = eurToCad.conversionFromEur.doubleValue / currencyToFind.conversionFromEur.doubleValue
        
        return oneCadToCurrency
    }
}
