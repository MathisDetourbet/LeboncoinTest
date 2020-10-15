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
    
    var isUrgent: Bool { model.isUrgent }
    
    var creationDate: Date {
        let creationDate: Date
        do {
            creationDate = try dataFormatter.date(from: model.creationDateString)
        } catch {
            creationDate = Date()
        }
        return creationDate
    }
}

// MARK: - Advertisement cell UI model conformance: can fill this kind of cell
extension AdvertisementViewModel: AdvertisementCellUIModel {
    var title: String                       { model.title }
    var adPictureUrl: URL?                  { model.imageEntity.smallImageUrl }
    var adDefaultPictureImageName: String   { model.imageEntity.defaultImageName }
    var categoryPictureImageName: String    { model.category.imageName }
    var isUrgentPictureImageName: String?   { model.isUrgentImageName }
    
    var price: String {
        let currencyString: String
        do {
            currencyString = try dataFormatter.currency(from: model.price)
        } catch DataFormatter.CurrencyFormatterError.badCurrencyNumber {
            currencyString = "Bad format"
        } catch {
            currencyString = ""
        }
        
        return currencyString
    }
}
