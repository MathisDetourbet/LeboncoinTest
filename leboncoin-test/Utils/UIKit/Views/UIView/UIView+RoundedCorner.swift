//
//  UIView+RoundedCorner.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 16/10/20.
//

import UIKit

extension UIView {
    func roundedCorner() {
        layer.cornerRadius = 5.0
        clipsToBounds = true
    }
}
