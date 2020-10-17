//
//  CollectionView+ViewModel.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 15/10/20.
//

import Foundation

protocol TableOrCollectionViewModel {
    associatedtype Model: Sequence
    var model: Model { get }
    
    var numberOfSections: Int { get }
    
    func numberOfItemsIn(_ section: Int) -> Int
    func elementAt(_ indexPath: IndexPath) -> Model.Element
}

extension TableOrCollectionViewModel where Model: Collection {
    var numberOfSections: Int { return 1 }
    
    func numberOfItemsIn(_ section: Int) -> Int {
        return model.count
    }
    
    func elementAt(_ indexPath: IndexPath) -> Model.Element {
        guard case 0...model.count = indexPath.row else {
            fatalError("model object cannot be found at row: \(indexPath.row)!")
        }
        let index = model.index(model.startIndex, offsetBy: indexPath.row)
        return model[index]
    }
}
