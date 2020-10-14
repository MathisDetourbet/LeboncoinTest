//
//  HTTPError.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 13/10/20.
//

import Foundation

enum HTTPError: LocalizedError {
    case badRequest             // code 400
    case unauthorized           // code 401
    case notFound               // code 404
    case internalServerError    // code 5xx
    case decodingError
    case noResponseData
    case unknown(Error)
    
    static func makeFromError(_ error: Error) -> HTTPError {
        if error is HTTPError {
            return error as! HTTPError
        } else {
            return HTTPError.unknown(error)
        }
    }
}
