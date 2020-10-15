//
//  AdvertisementListBusinessService.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 15/10/20.
//

import Foundation

protocol IAdvertisementListBusinessService {
    func fetchAdvertisementList(completion: @escaping (Result<[AdvertisementEntity], BusinessError>) -> Void)
}

class AdvertisementListBusinessService: IAdvertisementListBusinessService {
    private let dataAccessor: HTTPAdvsertisementsListDataAccessor
    
    init(dataAccessor: HTTPAdvsertisementsListDataAccessor) {
        self.dataAccessor = dataAccessor
    }
    
    func fetchAdvertisementList(completion: @escaping (Result<[AdvertisementEntity], BusinessError>) -> Void) {
        dataAccessor.fetchAdvertisementList { (result: Result<[AdvertisementModel], HTTPAdvsertisementsListDataAccessor.Err>) in
            completion(
                result.map { models -> [AdvertisementEntity] in
                    models.map(AdvertisementEntity.init)
                }
                .mapError { httpError -> BusinessError in
                    BusinessError.makeFromHttpError(httpError)
                }
            )
        }
    }
}
