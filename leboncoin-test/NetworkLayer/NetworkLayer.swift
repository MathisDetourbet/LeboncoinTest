//
//  NetworkLayer.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 13/10/20.
//

import Foundation

typealias NetworkCompletion<T: Decodable, U: Error> = (Result<T, U>) -> Void

protocol NetworkLayer {
    associatedtype Request: NetworkRequest
    associatedtype Err: Error
    
    func sendRequest<T: Decodable>(_ request: Request, completion: @escaping NetworkCompletion<T, Err>)
}
