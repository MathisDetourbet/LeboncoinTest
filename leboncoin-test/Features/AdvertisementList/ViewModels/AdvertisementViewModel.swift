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
}

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
