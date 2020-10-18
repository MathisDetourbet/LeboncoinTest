//
//  AdvertisementListBusinessServiceTests.swift
//  leboncoin-testTests
//
//  Created by Mathis Detourbet on 18/10/20.
//

import XCTest
@testable import leboncoin_test

fileprivate struct MockConfiguration: Configuration {
    var netProtocol: String = ""
    var domain: String = ""
    var path: String = ""
}

final class AdvertisementListBusinessServiceTests: XCTestCase {
    
    private var adsListBusinessService: AdvertisementListBusinessService!

    override func setUpWithError() throws {
        let configuration = MockConfiguration()
        let httpService = HTTPService()
        let dataAccessor = HTTPAdvsertisementsListDataAccessor(httpService: httpService, httpConfiguration: configuration)
        adsListBusinessService = AdvertisementListBusinessService(dataAccessor: dataAccessor)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
}
