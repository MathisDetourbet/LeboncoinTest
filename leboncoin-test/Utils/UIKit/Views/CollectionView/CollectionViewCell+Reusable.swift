//
//  CollectionViewCell+Reusable.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 15/10/20.
//

import UIKit

protocol ReusableCell: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableCell where Self: UICollectionViewCell {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UICollectionViewCell: ReusableCell {}
