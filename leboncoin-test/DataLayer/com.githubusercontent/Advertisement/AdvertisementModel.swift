//
//  AdvertisementModel.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 13/10/20.
//

import Foundation

struct AdvertisementModel {
    let id: UInt
    let categoryId: UInt
    let title: String
    let description: String
    let price: UInt
    let imageModel: ImageModel
    let creationDate: String
    let isUrgent: Bool
}

extension AdvertisementModel: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case categoryId = "category_id"
        case title
        case description
        case price
        case imageModel = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
    }
}
