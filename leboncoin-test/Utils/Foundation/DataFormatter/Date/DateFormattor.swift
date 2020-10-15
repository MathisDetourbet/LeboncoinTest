//
//  DateFormattor.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 15/10/20.
//

import Foundation

protocol DateFormattor {
    func date(from string: String) throws -> Date
}
