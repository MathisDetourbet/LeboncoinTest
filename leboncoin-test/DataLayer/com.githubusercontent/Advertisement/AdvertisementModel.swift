//
//  AdvertisementModel.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 13/10/20.
//

import Foundation

struct AdvertisementModel {
    let id: UInt
    let category_id: UInt
    let title: String
    let description: String
    let price: UInt
    let images_url: ImageModel
    let creation_date: String
    let is_urgent: Bool
}
