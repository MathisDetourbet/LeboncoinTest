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
    case booksCDDVD
    case multimedia
    case service
    case animals
    case children
    
    init?(categoryId: UInt) {
        switch categoryId {
        case 1:     self = .vehicle
        case 2:     self = .fashion
        case 3:     self = .diy
        case 4:     self = .home
        case 5:     self = .hobbies
        case 6:     self = .realEstate
        case 7:     self = .booksCDDVD
        case 8:     self = .multimedia
        case 9:     self = .service
        case 10:    self = .animals
        case 11:    self = .children
        default:    return nil
        }
    }
    
    var description: String {
        // Should return a localizable string
        switch self {
        case .vehicle:      return "Véhicule"
        case .fashion:      return "Mode"
        case .diy:          return "Bricolage"
        case .home:         return "Maison"
        case .hobbies:      return "Loisirs"
        case .realEstate:   return "Immobilier"
        case .booksCDDVD:   return "Livres/CD/DVD"
        case .multimedia:   return "Multimédia"
        case .service:      return "Service"
        case .animals:      return "Animaux"
        case .children:     return "Enfants"
        }
    }
    
    var picto: String {
        switch self {
        case .vehicle:      return "🚗"
        case .fashion:      return "🛍"
        case .diy:          return "🛠"
        case .home:         return "🏡"
        case .hobbies:      return "⛳️"
        case .realEstate:   return "🏢"
        case .booksCDDVD:   return "📚"
        case .multimedia:   return "🖥"
        case .service:      return "🤝"
        case .animals:      return "🐶"
        case .children:     return "👶"
        }
    }
    
    var id: UInt {
        // Categories are starting at 1
        return UInt((CategoryEntity.allCases.firstIndex(of: self) ?? 0 + 1))
    }
}

extension CategoryEntity {
    
    init?(from categoryId: UInt) {
        guard let category = CategoryEntity(categoryId: categoryId) else {
            return nil
        }
        self = category
    }
}
