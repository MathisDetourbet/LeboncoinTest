//
//  AdvertisementListViewModel.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 15/10/20.
//

import Foundation

struct AdvertisementListViewModel: CollectionViewModel {
    internal var model: [AdvertisementViewModel]
    
    let dataAccessor: HTTPAdvsertisementsListDataAccessor
    
    init(dataAccessor: HTTPAdvsertisementsListDataAccessor) {
        self.dataAccessor = dataAccessor
        self.model = []
    }
}
