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
    let imagesUrl: ImageModel
    let creationDate: String
    let isUrgent: Bool
}

extension AdvertisementModel: Decodable {
    enum AdvertisementModelKeys: String, CodingKey {
        case id
        case categoryId = "categoryId"
        case title
        case description
        case price
        case imagesUrl = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
    }
    
    init(from decoder: Decoder) throws {
        let container =     try decoder.container(keyedBy: AdvertisementModelKeys.self)
        
        self.id =           try container.decode(UInt.self, forKey: .id)
        self.categoryId =   try container.decode(UInt.self, forKey: .categoryId)
        self.title =        try container.decode(String.self, forKey: .title)
        self.description =  try container.decode(String.self, forKey: .description)
        self.price =        try container.decode(UInt.self, forKey: .price)
        self.imagesUrl =    try container.decode(ImageModel.self, forKey: .imagesUrl)
        self.creationDate = try container.decode(String.self, forKey: .creationDate)
        self.isUrgent =     try container.decode(Bool.self, forKey: .isUrgent)
    }
}
