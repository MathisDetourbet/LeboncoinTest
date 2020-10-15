//
//  BusinessError.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 15/10/20.
//

import Foundation

enum BusinessError: LocalizedError {
    case serverError
    case appError
    case unauthorizedUser
    case unknown(NSError)
    
    var errorDescription: String? {
        // Descriptions should be localized
        switch self {
        case .serverError:          return "Please try again later."
        case .appError:             return "Issue happened, please contact our customer support at contact@email.com."
        case .unauthorizedUser:     return "Resource you're trying to get is not available. You should be logged to have an access."
        case .unknown(let nsError): return "Unknown error: \(nsError.localizedDescription)"
        }
    }
    
    static func makeFromHttpError(_ httpError: HTTPError) -> Self {
        switch httpError {
        case .internalServerError, .noResponseData:     return .serverError
        case .badRequest, .decodingError, .notFound:    return .appError
        case .unauthorized:                             return .unauthorizedUser
        case .unknown(let error as NSError):            return .unknown(error)
        }
    }
}
