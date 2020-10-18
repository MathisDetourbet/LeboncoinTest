//
//  RootCoordinator.swift
//  leboncoin-testTests
//
//  Created by Mathis Detourbet on 18/10/20.
//

import XCTest
@testable import leboncoin_test

final class RootCoordinatorTests: XCTestCase {
    
    private var rootCoordinator: RootCoordinator!

    override func setUpWithError() throws {
        rootCoordinator = RootCoordinator(navigationController: UINavigationController())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_init_rootCoordinator_should_keep_navigationController_stack_empty() {
        XCTAssertTrue(rootCoordinator.navigationController.viewControllers.isEmpty)
    }

    func test_start_should_set_first_view_controller() {
        rootCoordinator.start()
        
        XCTAssertFalse(rootCoordinator.navigationController.viewControllers.isEmpty)
        XCTAssertTrue(rootCoordinator.navigationController.viewControllers.first! is AdvertisementListViewController)
    }
}
