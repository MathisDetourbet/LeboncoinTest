//
//  AdvertisementViewModel.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 15/10/20.
//

import Foundation

struct AdvertisementViewModel {
    let formatter: DateFormattor & CurrencyFormattor
    let model: AdvertisementEntity
}

extension AdvertisementViewModel: AdvertisementCellUIModel {
    var title: String { model.title }
    
    var price: String {
        let currencyString: String
        do {
            currencyString = try formatter.currency(from: model.price)
        } catch DataFormatter.CurrencyFormatterError.badCurrencyNumber {
            currencyString = "Bad format"
        } catch {
            currencyString = ""
        }
        
        return currencyString
    }
    
    var adPictureUrl: URL? { model.imageEntity.smallImageUrl }
    
    var adDefaultPictureImageName: String { model.imageEntity.defaultImageName }
    
    var categoryPictureImageName: String { model.category.imageName }
    
    var isUrgentPictureImageName: String? { model.isUrgentImageName }
    
    
}
