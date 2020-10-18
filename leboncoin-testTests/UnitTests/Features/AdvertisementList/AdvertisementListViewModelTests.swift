//
//  AdvertisementListViewModel.swift
//  leboncoin-testTests
//
//  Created by Mathis Detourbet on 18/10/20.
//

import XCTest
@testable import leboncoin_test

fileprivate class MockAdvertisementListBusinessService: IAdvertisementListBusinessService {
    func fetchAdvertisementList(completion: @escaping (Result<[AdvertisementEntity], BusinessError>) -> Void) {
        do {
            let adsEntities = try DataFactory.loadAdvertisementViewModelList()
            completion(.success(adsEntities))
        } catch {
            completion(.failure(BusinessError.appError))
        }
    }
}

class AdvertisementListViewModelTests: XCTestCase {
    
    private var viewModel: AdvertisementListViewModel!

    override func setUpWithError() throws {
        viewModel = AdvertisementListViewModel(businessService: MockAdvertisementListBusinessService())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: View Model init tests
    func test_rawList_should_be_empty_when_viewModel_init() {
        XCTAssertTrue(viewModel.rawList.isEmpty)
    }
    
    func test_viewableList_should_be_empty_when_viewModel_init() {
        XCTAssertTrue(viewModel.viewableList.isEmpty)
    }
    
    // MARK: View Model state tests
    func test_fetchAdvertisementList_should_make_rawList_not_empty() {
        let fixturesData = loadAdsEntitiesFixture()
        
        viewModel.fetchAdvertisementsList { [unowned self] _ in
            XCTAssertFalse(self.viewModel.rawList.isEmpty)
            XCTAssertEqual(self.viewModel.rawList.count, fixturesData.count)
        }
    }
    
    func test_viewableList_should_always_be_sorted_when_not_empty() {
        // Business rules:
        // - sorted by creationDate
        // - sorted by isUrgent equals true
        // - sorted by category if not nil
        let sortedIdsByBusinessRules = loadAdsEntitiesFixture()
            .map(AdvertisementViewModel.init)
            .sorted { $0.creationDate! < $1.creationDate! }
            .sorted {
                switch ($0.isUrgent, $1.isUrgent) {
                case (false, true): return false
                default: return true
                }
            }
            .map(\.idString)
        
        viewModel.fetchAdvertisementsList { [unowned self] _ in
            XCTAssertTrue(
                self.viewModel.viewableList
                    .map(\.idString)
                    .elementsEqual(sortedIdsByBusinessRules)
            )
        }
    }
    
    func test_rawList_didSet_should_process_data_and_set_viewableList() {
        viewModel.fetchAdvertisementsList { [unowned self] _ in
            XCTAssertFalse(self.viewModel.viewableList.isEmpty)
            XCTAssertFalse(
                self.viewModel.rawList
                    .map(\.idString)
                    .elementsEqual(
                        self.viewModel.viewableList.map(\.idString)
                    )
            )
        }
    }
    
    func test_newDataAvailable_should_be_called_when_fetching_data() {
        let dataAvailableExpectation = expectation(description: "expectation: call of newDataAvailable closure when fetchAdsList has been called")
        
        viewModel.newDataAvailable = {
            dataAvailableExpectation.fulfill()
        }
        
        viewModel.fetchAdvertisementsList { _ in }
        
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func test_newDataAvailable_should_be_called_when_categorySelected() {
        let dataAvailableExpectation = expectation(description: "expectation: call of newDataAvailable closure when didSelectCategory has beeen called")
        
        viewModel.fetchAdvertisementsList { _ in }
        
        viewModel.newDataAvailable = {
            dataAvailableExpectation.fulfill()
        }
        
        viewModel.didSelectCategory(.animals)
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func test_shouldDisplayRemoveFilterButton_should_be_called_when_category_updated() {
        let shouldDisplayExpectation = expectation(description: "expectation: call of shouldDisplayRemoveFilterButton closure when category is updated")
        
        viewModel.fetchAdvertisementsList { _ in }
        
        viewModel.shouldDisplayRemoveFilterButton = { _ in
            shouldDisplayExpectation.fulfill()
        }
        
        viewModel.didSelectCategory(.animals)
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func test_shouldDisplayRemoveFilterButton_should_send_false_when_removeFilter_called() {
        viewModel.fetchAdvertisementsList { _ in }
        
        viewModel.shouldDisplayRemoveFilterButton = { shouldDisplay in
            XCTAssertFalse(shouldDisplay, "closure shouldDisplayRemoveFilterButton should send false when removeCategoryFilter has been called")
        }
        
        viewModel.removeCategoryFilter()
    }
    
    func test_shouldDisplayRemoveFilterButton_should_send_true_when_didSelectCategory_called() {
        viewModel.fetchAdvertisementsList { _ in }
        
        viewModel.shouldDisplayRemoveFilterButton = { shouldDisplay in
            XCTAssertTrue(shouldDisplay, "closure shouldDisplayRemoveFilterButton should send true when didSelectCategory has been called")
        }
        
        viewModel.didSelectCategory(.animals)
    }
    
    // MARK: Category Picker Delegate
    func test_categorySelected_should_sort_viewableList_by_category() {
        // To check if viewableList has been sorted by category
        // we need to take the first category from the fixture
        // then select another category to check if that category
        // is not at the first index as before
        let fixturesData = loadAdsEntitiesFixture()
        let firstCategory = fixturesData.first!.category
        let categorySelected = CategoryEntity.allCases.first { $0 != firstCategory }!
        
        viewModel.fetchAdvertisementsList { [unowned self] _ in
            XCTAssertNotEqual(self.viewModel.viewableList.first!.category, categorySelected)
            self.viewModel.didSelectCategory(categorySelected)
            XCTAssertEqual(self.viewModel.viewableList.first!.category, categorySelected)
        }
    }
}

extension AdvertisementListViewModelTests {
    private func loadAdsEntitiesFixture() -> [AdvertisementEntity] {
        let fixturesData: [AdvertisementEntity]
        do {
            fixturesData = try DataFactory.loadAdvertisementViewModelList()
        } catch {
            fixturesData = []
            XCTFail("Fixture load failed")
        }
        return fixturesData
    }
}
