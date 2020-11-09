//
//  AdvsertisementsListDataAccess.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 14/10/20.
//

import Foundation

protocol AdvsertisementsListDataAccess {
    func fetchAdvertisementList(completion: @escaping (Result<[AdvertisementModel], Error>) -> Void)
}

struct HTTPAdvsertisementsListDataAccessor: AdvsertisementsListDataAccess {
    private let httpService: NetworkLayer
    private let httpConfiguration: Configuration
    
    init(httpService: NetworkLayer, httpConfiguration: Configuration) {
        self.httpService = httpService
        self.httpConfiguration = httpConfiguration
    }
    
    func fetchAdvertisementList(completion: @escaping (Result<[AdvertisementModel], Error>) -> Void) {
        let httpRequest = HTTPRequest(
            baseUrl: httpConfiguration.urlScheme,
            endPoint: .advertisementsList,
            method: .get,
            headers: nil,
            parameters: nil
        )
        httpService.sendRequest(httpRequest, completion: completion)
    }
}
