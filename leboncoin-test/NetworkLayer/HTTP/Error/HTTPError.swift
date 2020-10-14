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
    case unknown(Error?)
    
    private static func makeFromErrorStatusCode(_ statusCode: Int) -> HTTPError {
        switch statusCode {
        case 400:       return .badRequest
        case 401:       return .unauthorized
        case 404:       return .notFound
        case 500..<600: return .internalServerError
        default:        return .unknown(NSError(domain: "unknown error", code: statusCode, userInfo: nil))
        }
    }
    
    static func makeFromHTTPURLResponse(_ httpResponse: HTTPURLResponse) -> HTTPError {
        return makeFromErrorStatusCode(httpResponse.statusCode)
    }
    
    static func makeFromNSError(_ error: NSError) -> HTTPError {
        return makeFromErrorStatusCode((error as NSError).code)
    }
}
