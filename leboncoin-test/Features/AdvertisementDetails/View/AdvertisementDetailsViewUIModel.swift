//
//  AdvertisementDetailsViewUIModel.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 16/10/20.
//

import Foundation

// MARK: - UI Model to fill AdvertisementDetailsView
protocol AdvertisementDetailsViewUIModel {
    var idString: String                { get }
    var titleString: String             { get }
    var descriptionString: String       { get }
    var categoryIdString: String        { get }
    var priceString: String             { get }
    var smallAdImageUrlString: String   { get }
    var smallAdImageUrl: URL?           { get }
    var largeAdImageUrlString: String   { get }
    var largeAdImageUrl: URL?           { get }
    var creationDateString: String      { get }
    var isUrgentString: String          { get }
}

// MARK: - AdvertisementDetails View  UI model conformance: can fill this kind of view
extension AdvertisementViewModel: AdvertisementDetailsViewUIModel {
    
    var idString: String            { "id: \(model.id)" }
    var titleString: String         { "Title: \(model.title)" }
    var descriptionString: String   { "Description: \(model.description)" }
    var priceString: String         { "Price: \(model.price)" }
    var creationDateString: String  { "Creation date: \(model.creationDateString)" }
    var isUrgentString: String      { "isUrgent: \(model.isUrgent.description)" }
    var smallAdImageUrl: URL?       { model.imageEntity.smallImageUrl }
    var largeAdImageUrl: URL?       { model.imageEntity.largeImageUrl }
    
    var categoryIdString: String {
        guard let id = model.category?.id else { return "Category id: no id" }
        return "Category id: \(id)"
    }
    
    var smallAdImageUrlString: String  {
        guard let url = model.imageEntity.smallImageUrl else { return "Small image url: no url" }
        return url.absoluteString
    }
    
    var largeAdImageUrlString: String  {
        guard let url = model.imageEntity.largeImageUrl else { return "Large image url: no url" }
        return url.absoluteString
    }
}
