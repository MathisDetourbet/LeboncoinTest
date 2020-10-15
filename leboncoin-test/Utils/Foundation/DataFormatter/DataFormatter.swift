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
    
    func currency(from unsignedInt: UInt) throws -> String {
        guard let currency = currencyFormatter.number(from: String(unsignedInt)) else {
            throw CurrencyFormatterError.badCurrencyNumber
        }
        
        return currency.stringValue
    }
}
