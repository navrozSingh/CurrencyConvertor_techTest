//
//  CurrencyConvertorViewModalTests.swift
//  CurrencyConvertorTests
//
//  Created by Navroz on 22/08/21.
//

import XCTest
@testable import CurrencyConvertor

class CurrencyConvertorViewModalTests: XCTestCase {
    var subject: CurrencyConvertorViewModal!
    let requirement = MockRequirement()
    
    override func setUp() {
        let modals = Array.init(repeating: CurrencyModal.init(), count: 2)
        subject = CurrencyConvertorViewModal.init(dataSource: modals,
                                                  allCurrencies: [AllCurreniesModal]())
        subject.requirement = requirement
    }
    
    func testRequirements() {
        subject.editDataSourceAt(0)
        subject.deleteDataSourceAt(0)
        
        XCTAssertEqual(requirement.showAddCurrencyCalled, true)
        XCTAssertEqual(requirement.updateWalletCardCalled, true)
    }
    
    func testDelete() {
        subject.deleteDataSourceAt(0)
        XCTAssertEqual(subject.dataSource.count, 1)
    }
    
}


class MockRequirement: CurrencyConvertorRequirement {
    var updateWalletCardCalled = false
    var reloadDataSourceCalled = false
    var showAddCurrencyCalled = false

    
    func updateWalletCard(amount: String, selectedCurrencyCount: Int) {
        updateWalletCardCalled = true
    }
    
    func reloadDataSource() {
        reloadDataSourceCalled = true
    }
    
    func showAddCurrency(with viewModal: AddCurrencyViewModal) {
        showAddCurrencyCalled = true
    }
}
