//
//  DataFormatterTests.swift
//  leboncoin-testTests
//
//  Created by Mathis Detourbet on 18/10/20.
//

import XCTest
@testable import leboncoin_test

class DataFormatterTests: XCTestCase {
    
    private var dataFormatter: DataFormatter!

    override func setUpWithError() throws {
        dataFormatter = DataFormatter()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_dateFromString_should_return_ISO8601_date_format() {
        let isoDateString = "1977-04-22T06:00:00Z"
        let isoFormattedDate = ISO8601DateFormatter().date(from: isoDateString)!
        
        let formatterResult = try! dataFormatter.date(from: isoDateString)
        
        XCTAssertEqual(isoFormattedDate, formatterResult)
    }
    
    func test_currencyFromUInt_should_return_formatted_currency() {
        let price = 123.45 as Double
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.maximumFractionDigits = 2
        
        let currencyStringExample = currencyFormatter.string(from: NSNumber(value: price))!
        let currencyString = try! dataFormatter.currency(from: price)
        
        XCTAssertEqual(currencyString, currencyStringExample)
    }
}
