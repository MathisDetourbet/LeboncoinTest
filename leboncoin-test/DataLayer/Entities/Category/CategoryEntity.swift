//
//  CategoryEntity.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 15/10/20.
//

import Foundation

enum CategoryEntity: CustomStringConvertible, CaseIterable {
    case vehicle
    case fashion
    case diy
    case home
    case hobbies
    case realEstate
    case booksCDDVC
    case multimedia
    case service
    case animals
    case children
    case unknown
    
    var description: String {
        // Should return a localizable string
        switch self {
        case .vehicle:      return "Véhicule"
        case .fashion:      return "Mode"
        case .diy:          return "Bricolage"
        case .home:         return "Maison"
        case .hobbies:      return "Loisirs"
        case .realEstate:   return "Immobilier"
        case .booksCDDVC:   return "Livres/CD/DVD"
        case .multimedia:   return "Multimédia"
        case .service:      return "Service"
        case .animals:      return "Animaux"
        case .children:     return "Enfants"
        case .unknown:      return ""
        }
    }
    
    var imageName: String {
        switch self {
        case .vehicle:      return "Véhicule"
        case .fashion:      return "Mode"
        case .diy:          return "Bricolage"
        case .home:         return "Maison"
        case .hobbies:      return "Loisirs"
        case .realEstate:   return "Immobilier"
        case .booksCDDVC:   return "Livres/CD/DVD"
        case .multimedia:   return "Multimédia"
        case .service:      return "Service"
        case .animals:      return "Animaux"
        case .children:     return "Enfants"
        case .unknown:       return ""
        }
    }
    
    static func makeCategoryFromId(_ categoryId: UInt) -> CategoryEntity {
        switch categoryId {
        case 1:     return .vehicle
        case 2:     return .fashion
        case 3:     return .diy
        case 4:     return .home
        case 5:     return .hobbies
        case 6:     return .realEstate
        case 7:     return .booksCDDVC
        case 8:     return .multimedia
        case 9:     return .service
        case 10:    return .animals
        case 11:    return .children
        default:    return .unknown
        }
    }
}

extension CategoryEntity: ModelInitializable {
    
    init(from categoryId: UInt) {
        self = CategoryEntity.makeCategoryFromId(categoryId)
    }
}
