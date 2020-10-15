//
//  AdvsertisementsListDataAccess.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 14/10/20.
//

import Foundation

protocol AdvsertisementsListDataAccess {
    associatedtype Err: Error
    func fetchAdvertisementList(completion: @escaping (Result<[AdvertisementModel], Err>) -> Void)
}

struct HTTPAdvsertisementsListDataAccessor: AdvsertisementsListDataAccess {
    typealias Err = HTTPError
    private let httpService: HTTPService
    private let httpConfiguration: Configuration
    
    init(httpService: HTTPService, httpConfiguration: Configuration) {
        self.httpService = httpService
        self.httpConfiguration = httpConfiguration
    }
    
    func fetchAdvertisementList(completion: @escaping (Result<[AdvertisementModel], Err>) -> Void) {
        let httpRequest = HTTPRequest(
            baseUrl: httpConfiguration.urlScheme,
            endPoint: .advertisementsList,
            method: .GET,
            headers: nil,
            parameters: nil
        )
        httpService.sendRequest(httpRequest, completion: completion)
    }
}
