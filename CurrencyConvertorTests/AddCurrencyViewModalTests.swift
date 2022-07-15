//
//  AddCurrencyViewModalTests.swift
//  CurrencyConvertorTests
//
//  Created by Navroz on 23/08/21.
//

import XCTest
@testable import CurrencyConvertor

class AddCurrencyViewModalTests: XCTestCase {
    var subject: AddCurrencyViewModal!
    let requirement = MockAddCurrencyRequirement()
    
    override func setUp() {
        let list = [AllCurreniesModal.init(currency: "INR", conversionFromEur: NSNumber(value: 1))]
        subject = AddCurrencyViewModal.init(currencyList: list, selectedModal: CurrencyModal.init())
        subject.requirement = requirement
    }

    func testflag() {
        XCTAssertEqual(subject.flag(for: "INR"), "🇮🇳")
        XCTAssertNil(subject.flag(for: "WrongCurrencyCode"))
    }
    
    func testSave() {
        subject.save(with: "INR", amount: "1000")
        XCTAssertEqual(subject.selectedModal.amount, "1000")
        XCTAssertEqual(subject.selectedModal.currency, "INR")
        XCTAssertEqual(requirement.dismissCalled, true)
    }
}

class MockAddCurrencyRequirement: AddCurrencyRequirement {
    var dismissCalled = false
    func dismiss() {
        dismissCalled = true
    }
}
