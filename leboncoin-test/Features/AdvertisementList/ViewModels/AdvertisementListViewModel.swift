//
//  AdvertisementListViewModel.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 15/10/20.
//

import Foundation

final class AdvertisementListViewModel: TableOrCollectionViewModel {
    // MARK: Inputs
    let businessService: IAdvertisementListBusinessService
    
    /// Array of ads fetched from the API, dont use it to display it, use list property instead
    var rawList: [AdvertisementViewModel] { didSet { viewableList = rawList } }
    
    // MARK: Outputs
    /// Array of ads builed from rawList property used to be display as wanted. Can be sorted. filtered, etc.
    var viewableList: [AdvertisementViewModel] { didSet { newDataAvailable?() } }
    
    /// Closure called when new data is available and ready to be displayed
    var newDataAvailable: (() -> Void)?
    
    private var categorySelected: CategoryEntity? {
        didSet { sortAdvertisementsList() }
    }
    
    init(businessService: IAdvertisementListBusinessService) {
        self.businessService = businessService
        self.rawList = []
        self.viewableList = []
    }
    
    func fetchAdvertisementsList(completion: @escaping (BusinessError?) -> Void) {
        businessService.fetchAdvertisementList { [weak self] (result: Result<[AdvertisementEntity], BusinessError>) in
            switch result {
            
            case .success(let advertisementsEntity):
                let adsViewModels = advertisementsEntity.map(AdvertisementViewModel.init)
                self?.rawList = AdvertisementListViewModel.sortedAdvertisementsList(adsViewModels, by: self?.categorySelected)
                completion(nil)
                
            case .failure(let businessError):
                completion(businessError)
            }
        }
    }
    
    private func sortAdvertisementsList() {
        // Always take the raw list to ensure to have all data
        let currentAds = rawList
        let preparedAds = AdvertisementListViewModel.sortedAdvertisementsList(currentAds, by: categorySelected)
        viewableList = preparedAds
    }
}

// MARK: - Business rule: sort ads by date and isUrgent equals true & filter by category
private extension AdvertisementListViewModel {
    static func sortedAdvertisementsList(_ ads: [AdvertisementViewModel], by category: CategoryEntity?) -> [AdvertisementViewModel] {
        // Sort by date first
        let sortedAdsByDate = AdvertisementListViewModel.sortedByDate(ads: ads)
        
        // Then, sort by isUrgent equals true
        let sortedAdsByIsUrgent = AdvertisementListViewModel.sortedByIsUrgent(ads: sortedAdsByDate)
        
        // Finally, filter ads by category if needed
        let filteredAdsByCategory = AdvertisementListViewModel.filterByCategory(category, ads: sortedAdsByIsUrgent)
        
        return filteredAdsByCategory
    }
    
    static func sortedByDate(ads: [AdvertisementViewModel]) -> [AdvertisementViewModel] {
        return ads.sorted {
            // Here we put `nil` dates at the back the stack
            guard let date = $0.creationDate else {
                return false
            }
            
            guard let nextDate = $1.creationDate else {
                return true
            }
            
            return date < nextDate
        }
    }
    
    static func sortedByIsUrgent(ads: [AdvertisementViewModel]) -> [AdvertisementViewModel] {
        return ads.sorted {
            switch ($0.isUrgent, $1.isUrgent) {
            case (false, true): return false
            default: return true
            }
        }
    }
    
    static func filterByCategory(_ category: CategoryEntity?, ads: [AdvertisementViewModel]) -> [AdvertisementViewModel] {
        guard let category = category else {
            return ads
        }
        return ads.filter { $0.category == category }
    }
}

extension AdvertisementListViewModel: CategoryPickerDelegate {
    
    func didSelectCategory(_ category: CategoryEntity) {
        categorySelected = category
    }
}
