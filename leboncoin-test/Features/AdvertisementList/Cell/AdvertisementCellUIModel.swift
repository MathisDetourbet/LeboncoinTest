//
//  AdvertisementCellUIModel.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 16/10/20.
//

import Foundation

// MARK: - UI Model to configure AdvertisementCollectionViewCell
protocol AdvertisementCellUIModel {
    var title: String                       { get }
    var price: String                       { get }
    var adPictureUrl: URL?                  { get }
    var adDefaultPictureImageName: String   { get }
    var categoryPictureImageName: String?   { get }
    var isUrgentPictureImageName: String?   { get }
}

// MARK: - Advertisement cell UI model conformance: can fill this kind of cell
extension AdvertisementViewModel: AdvertisementCellUIModel {
    var title: String                       { model.title }
    var adPictureUrl: URL?                  { model.imageEntity.smallImageUrl }
    var adDefaultPictureImageName: String   { model.imageEntity.defaultImageName }
    var categoryPictureImageName: String?   { model.category?.imageName }
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
