//
//  AdvertisementViewModel.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 15/10/20.
//

import Foundation

struct AdvertisementViewModel {
    let dataFormatter: DateFormattor & CurrencyFormattor = DataFormatter()
    let model: AdvertisementEntity
    
    var category: CategoryEntity? { model.category }
    var isUrgent: Bool { model.isUrgent }
    
    var creationDate: Date? {
        let creationDate: Date?
        do {
            creationDate = try dataFormatter.date(from: model.creationDateString)
        } catch {
            creationDate = nil
        }
        return creationDate
    }
}
