//
//  CategoryPickerViewModel.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 17/10/20.
//

import Foundation

struct CategoryPickerViewModel: TableOrCollectionViewModel {
    var viewableList: CategoryEntity.AllCases
    
    init() {
        self.viewableList = CategoryEntity.allCases
    }
}
