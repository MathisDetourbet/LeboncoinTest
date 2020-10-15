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
    
    private static func sortedAdvertisementsList(ads: [AdvertisementViewModel]) -> [AdvertisementViewModel] {
        // Sort by date first
        let sortedByDate = ads.sorted { $0.creationDate < $1.creationDate }
        
        // Then, sort by isUrgent is true
        let isUrgentSorted = sortedByDate.sorted {
            switch ($0.isUrgent, $1.isUrgent) {
            case (false, true): return false
            default: return true
            }
        }
        
        return isUrgentSorted
    }
}
