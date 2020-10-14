//
//  HTTPRequest.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 13/10/20.
//

import Foundation

protocol NetworkRequest {
    var baseUrl: String { get }
}

struct HTTPRequest: NetworkRequest {
    let baseUrl: String
    let endPoint: HTTPEndPoint
    let method: HTTPMethod
    let headers: HTTPHeaders?
    let parameters: Encodable?
    
    var fullUrl: URL? {
        return URL(string: baseUrl + endPoint.description)
    }
}
