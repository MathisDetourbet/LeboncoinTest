//
//  CategoryPickerViewModel.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 17/10/20.
//

import Foundation

struct CategoryPickerViewModel: TableOrCollectionViewModel {
    var model: CategoryEntity.AllCases
    
    init() {
        self.model = CategoryEntity.allCases
    }
}
