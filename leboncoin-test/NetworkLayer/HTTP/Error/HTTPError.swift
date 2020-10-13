//
//  HTTPError.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 13/10/20.
//

import Foundation

enum HTTPError: LocalizedError {
    case notFound // code 404
    case internalServerError // code 5xx
    case badRequest // code 400
    case unauthorized // code 401
}
