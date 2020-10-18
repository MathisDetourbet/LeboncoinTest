//
//  DateFormatter.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 15/10/20.
//

import Foundation

final class DataFormatter {
    private lazy var dateISOFormatter: ISO8601DateFormatter = {
        let dateFormattor = ISO8601DateFormatter()
        return dateFormattor
    }()
    
    private lazy var currencyFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }()
}

// MARK: - Date Formatter
extension DataFormatter: DateFormattor {
    enum DateFormatterError: LocalizedError {
        case badDateFormat
    }
    
    func date(from string: String) throws -> Date {
        guard let date = dateISOFormatter.date(from: string) else {
            throw DateFormatterError.badDateFormat
        }
        
        return date
    }
}

// MARK: - Currency Formatter
extension DataFormatter: CurrencyFormattor {
    enum CurrencyFormatterError: LocalizedError {
        case badCurrencyNumber
    }
    
    func currency(from double: Double) throws -> String {
        guard let currencyString = currencyFormatter.string(from: NSNumber(value: double)) else {
            throw CurrencyFormatterError.badCurrencyNumber
        }
        
        return currencyString
    }
}
