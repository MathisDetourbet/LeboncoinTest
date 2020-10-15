//
//  ModelInitializable.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 15/10/20.
//

import Foundation

protocol ModelInitializable {
    associatedtype Model
    init(from model: Model)
}
