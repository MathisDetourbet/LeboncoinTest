//
//  HTTPAdvsertisementsListDataAccessorTests.swift
//  leboncoin-testTests
//
//  Created by Mathis Detourbet on 18/10/20.
//

import XCTest
@testable import leboncoin_test

fileprivate struct MockHTTPConfiguration: Configuration {
    var netProtocol: String = "http://"
    var domain: String = "www.api-domain-to-adslist/"
    var path: String = "adslist-path/"
}

fileprivate struct MockHTTPService: NetworkLayer {
    let fetchHTTPServiceExpectation: XCTestExpectation?
    let fetchHTTPRequestExpectation: XCTestExpectation?
    
    func sendRequest<T>(_ request: NetworkRequest, completion: @escaping NetworkCompletion<T>) where T : Decodable {
        fetchHTTPServiceExpectation?.fulfill()
        
        if let httpRequest = request as? HTTPRequest,
           httpRequest.method == .GET,
           httpRequest.endPoint == .advertisementsList,
           httpRequest.headers == nil,
           httpRequest.parameters == nil,
           httpRequest.baseUrl == URL(string: "http://www.api-domain-to-adslist/adslist-path/")! {
            fetchHTTPRequestExpectation?.fulfill()
        }
    }
}

final class HTTPAdvsertisementsListDataAccessorTests: XCTestCase {
    
    private var dataAccessor: HTTPAdvsertisementsListDataAccessor!
    private let mockConfiguration = MockHTTPConfiguration()

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {
        dataAccessor = nil
    }
    
    func test_fetAdsList_should_call_networkLayer() {
        let fetchHTTPServiceExpectation = expectation(description: "expectation: call NetworkLayer fetchAdvertisementList method")
        let mockNetworkService = MockHTTPService(fetchHTTPServiceExpectation: fetchHTTPServiceExpectation, fetchHTTPRequestExpectation: nil)
        dataAccessor = HTTPAdvsertisementsListDataAccessor(httpService: mockNetworkService, httpConfiguration: mockConfiguration)
        
        dataAccessor.fetchAdvertisementList { _ in }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func test_fetchAdsList_should_create_and_send_HTTPRequest() {
        let fetchHTTPRequestExpectation = expectation(description: "expectation: create and send correct HTTPRequest object to NetworkLayer")
        let mockNetworkService = MockHTTPService(fetchHTTPServiceExpectation: nil, fetchHTTPRequestExpectation: fetchHTTPRequestExpectation)
        dataAccessor = HTTPAdvsertisementsListDataAccessor(httpService: mockNetworkService, httpConfiguration: mockConfiguration)
        
        dataAccessor.fetchAdvertisementList { _ in }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}
