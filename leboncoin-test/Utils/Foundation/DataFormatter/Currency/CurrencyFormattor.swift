//
//  CurrencyFormattor.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 15/10/20.
//

import Foundation

protocol CurrencyFormattor {
    func currency(from unsignedInt: UInt) throws -> String
}
