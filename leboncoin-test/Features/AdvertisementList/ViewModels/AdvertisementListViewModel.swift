//
//  AdvertisementListViewModel.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 15/10/20.
//

import Foundation

final class AdvertisementListViewModel: CollectionViewModel {
    internal var model: [AdvertisementViewModel]
    
    let businessService: IAdvertisementListBusinessService
    
    init(businessService: IAdvertisementListBusinessService) {
        self.businessService = businessService
        self.model = []
    }
    
    func fetchAdvertisementsList(completion: @escaping (BusinessError?) -> Void) {
        businessService.fetchAdvertisementList { [weak self] (result: Result<[AdvertisementEntity], BusinessError>) in
            switch result {
            case .success(let advertisementsEntity):
                self?.model = advertisementsEntity.map(AdvertisementViewModel.init)
                completion(nil)
            case .failure(let businessError):
                completion(businessError)
            }
        }
    }
}
