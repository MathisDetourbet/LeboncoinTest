//
//  DataFactory.swift
//  leboncoin-testTests
//
//  Created by Mathis Detourbet on 18/10/20.
//

import Foundation
@testable import leboncoin_test

class DataFactory {
    
    enum FactoryError: Error {
        case resourceNotFound
        case decodingError
    }
    
    private static func loadFixture<T: Decodable>(resource: String) throws -> T {
        let bundle = Bundle(for: self)
        guard let path = bundle.path(forResource: resource, ofType: "json") else {
            throw FactoryError.resourceNotFound
        }
        
        let fileUrl = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: fileUrl)
            let jsonDecoder = JSONDecoder()
            let decodedObjects = try jsonDecoder.decode(T.self, from: data)
            return decodedObjects
        } catch {
            throw FactoryError.decodingError
        }
    }
    
    static func loadAdvertisementViewModelList() throws -> [AdvertisementEntity] {
        do {
            let adsModel: [AdvertisementModel] = try loadFixture(resource: "adsList")
            return adsModel.map(AdvertisementEntity.init)
            
        } catch let error as FactoryError {
            throw error
        }
    }
    
    static func loadCategoriesList() -> [CategoryEntity] {
        return CategoryEntity.allCases
    }
}
