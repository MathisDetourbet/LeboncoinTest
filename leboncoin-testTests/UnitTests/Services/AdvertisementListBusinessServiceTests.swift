//
//  AdvertisementListBusinessServiceTests.swift
//  leboncoin-testTests
//
//  Created by Mathis Detourbet on 18/10/20.
//

import XCTest
@testable import leboncoin_test

fileprivate struct MockDataAccess: AdvsertisementsListDataAccess {
    let fetchExpectation: XCTestExpectation?
    
    func fetchAdvertisementList(completion: @escaping (Result<[AdvertisementModel], Error>) -> Void) {
        fetchExpectation?.fulfill()
    }
}

final class AdvertisementListBusinessServiceTests: XCTestCase {
    
    private var adsListBusinessService: AdvertisementListBusinessService!

    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}
    
    func test_fetchAdsList_should_call_dataAccessor() {
        let fetchExpectation = expectation(description: "expectation: call dataAccessor fetchAdvertisementList method")
        let dataAccessor = MockDataAccess(fetchExpectation: fetchExpectation)
        adsListBusinessService = AdvertisementListBusinessService(dataAccessor: dataAccessor)
        
        adsListBusinessService.fetchAdvertisementList { _ in }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}
