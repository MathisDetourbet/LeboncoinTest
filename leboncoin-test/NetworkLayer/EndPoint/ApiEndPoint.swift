//
//  ApiEndPoints.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 13/10/20.
//

import Foundation

enum ApiEndPoint: CustomStringConvertible {
    case advertisementsList
    case advertisementsCategories
    
    var description: String {
        switch self {
        case .advertisementsList: return "/listing.json"
        case .advertisementsCategories: return "/categories.json"
        }
    }
}
