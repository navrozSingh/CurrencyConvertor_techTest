//
//  NetworkAdaptorTests.swift
//  CurrencyConvertorTests
//
//  Created by Navroz on 22/08/21.
//

import XCTest
@testable import CurrencyConvertor

class NetworkAdaptorTests: XCTestCase {
    let subject = Network()
    
    func testNetworkAdaptor() {
        XCTAssertEqual(subject.baseUrl, URL(string: "https://swop.cx/graphql")!)
        XCTAssertEqual(subject.headers.count, 1)
    }
}
