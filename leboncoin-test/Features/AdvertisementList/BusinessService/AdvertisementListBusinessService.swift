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

final class AdvertisementListBusinessService: IAdvertisementListBusinessService {
    private let dataAccessor: AdvsertisementsListDataAccess
    
    init(dataAccessor: AdvsertisementsListDataAccess) {
        self.dataAccessor = dataAccessor
    }
    
    func fetchAdvertisementList(completion: @escaping (Result<[AdvertisementEntity], BusinessError>) -> Void) {
        dataAccessor.fetchAdvertisementList { (result: Result<[AdvertisementModel], Error>) in
            completion(
                result.map { models -> [AdvertisementEntity] in
                    models.map(AdvertisementEntity.init)
                }
                .mapError { error -> BusinessError in
                    guard let httpError = error as? HTTPError else {
                        return BusinessError.unknown(error as NSError)
                    }
                    return BusinessError.makeFromHttpError(httpError)
                }
            )
        }
    }
}
