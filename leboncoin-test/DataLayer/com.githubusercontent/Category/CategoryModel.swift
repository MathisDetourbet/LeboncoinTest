//
//  CategoryModel.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 15/10/20.
//

import Foundation

struct CategoryModel {
    let id: UInt
    let name: String
}

extension CategoryModel: Decodable {}
