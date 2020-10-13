//
//  NetworkLayer.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 13/10/20.
//

import Foundation

protocol NetworkLayer {
    func sendRequest<T: Decodable>(with properties: RequestProperties) -> Result<T, Error>
}
