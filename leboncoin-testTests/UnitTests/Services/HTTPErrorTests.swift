//
//  HTTPErrorTests.swift
//  leboncoin-testTests
//
//  Created by Mathis Detourbet on 14/10/20.
//

import Foundation
import XCTest
@testable import leboncoin_test

final class HTTPErrorTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private func makeHTTPURLResponse(with statusCode: Int) -> HTTPURLResponse? {
        let badRequest = HTTPURLResponse(
            url: URL(string: "www.google.com")!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )
        return badRequest
    }
    
    func test_makeFromHTTPURLResponse_should_return_HTTPError_badRequest_when_statusCode_400() throws {
        guard let badRequest = makeHTTPURLResponse(with: 400) else {
            XCTFail("makeHTTPURLResponse returns nil")
            return
        }
        
        let httpError = HTTPError.makeFromHTTPURLResponse(badRequest)
        XCTAssertEqual(httpError, .badRequest)
    }

    func test_makeFromHTTPURLResponse_should_return_HTTPError_unauthorized_when_statusCode_401() throws {
        guard let badRequest = makeHTTPURLResponse(with: 401) else {
            XCTFail("makeHTTPURLResponse returns nil")
            return
        }
        
        let httpError = HTTPError.makeFromHTTPURLResponse(badRequest)
        XCTAssertEqual(httpError, .unauthorized)
    }
    
    func test_makeFromHTTPURLResponse_should_return_HTTPError_notFound_when_statusCode_404() throws {
        guard let badRequest = makeHTTPURLResponse(with: 404) else {
            XCTFail("makeHTTPURLResponse returns nil")
            return
        }
        
        let httpError = HTTPError.makeFromHTTPURLResponse(badRequest)
        XCTAssertEqual(httpError, .notFound)
    }
    
    func test_makeFromHTTPURLResponse_should_return_HTTPError_internalServerError_when_statusCode_500() throws {
        guard let badRequest = makeHTTPURLResponse(with: 500) else {
            XCTFail("makeHTTPURLResponse returns nil")
            return
        }
        
        let httpError = HTTPError.makeFromHTTPURLResponse(badRequest)
        XCTAssertEqual(httpError, .internalServerError)
    }
}
