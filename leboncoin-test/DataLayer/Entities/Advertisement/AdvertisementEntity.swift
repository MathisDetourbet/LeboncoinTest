//
//  AdvertisementEntity.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 15/10/20.
//

import Foundation

struct AdvertisementEntity {
    let title: String
    let price: UInt
    let category: CategoryEntity
    let description: String
    let imageEntity: ImageEntity
    let creationDateString: String
    let isUrgent: Bool
    
    var isUrgentImageName: String? {
        if isUrgent {
            return ""
        } else {
            return nil
        }
    }
}

extension AdvertisementEntity: ModelInitializable {
    init(from model: AdvertisementModel) {
        self.title = model.title
        self.price = model.price
        self.category = CategoryEntity(from: model.categoryId)
        self.description = model.description
        self.imageEntity = ImageEntity(from: model.imageModel)
        self.creationDateString = model.creationDate
        self.isUrgent = model.isUrgent
    }
}
