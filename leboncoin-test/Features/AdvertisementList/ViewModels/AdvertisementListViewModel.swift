//
//  AdvertisementListViewModel.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 15/10/20.
//

import Foundation

final class AdvertisementListViewModel: CollectionViewModel {
    let businessService: IAdvertisementListBusinessService
    var model: [AdvertisementViewModel]
    
    init(businessService: IAdvertisementListBusinessService) {
        self.businessService = businessService
        self.model = []
    }
    
    func fetchAdvertisementsList(completion: @escaping (BusinessError?) -> Void) {
        businessService.fetchAdvertisementList { [weak self] (result: Result<[AdvertisementEntity], BusinessError>) in
            switch result {
            
            case .success(let advertisementsEntity):
                let adsViewModels = advertisementsEntity.map(AdvertisementViewModel.init)
                self?.model = AdvertisementListViewModel.sortedAdvertisementsList(ads: adsViewModels)
                completion(nil)
                
            case .failure(let businessError):
                completion(businessError)
            }
        }
    }
}

// MARK: - Business rule: sort ads by date and isUrgent equals true
private extension AdvertisementListViewModel {
    static func sortedAdvertisementsList(ads: [AdvertisementViewModel]) -> [AdvertisementViewModel] {
        // Sort by date first
        let sortedByDate = AdvertisementListViewModel.sortedByDate(ads: ads)
        
        // Then, sort by isUrgent equals true
        let sortedByIsUrgent = AdvertisementListViewModel.sortedByIsUrgent(ads: sortedByDate)
        
        return sortedByIsUrgent
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
}
