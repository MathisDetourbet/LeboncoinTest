//
//  NetworkLayer.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 13/10/20.
//

import Foundation

typealias NetworkCompletion<T: Decodable> = (Result<T, Error>) -> Void

protocol NetworkLayer {
    func sendRequest<T: Decodable>(_ request: NetworkRequest, completion: @escaping NetworkCompletion<T>)
}
