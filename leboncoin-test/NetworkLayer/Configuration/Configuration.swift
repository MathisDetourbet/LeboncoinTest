//
//  Configuration.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 13/10/20.
//

import Foundation

protocol Configuration {
    var netProtocol: String { get }
    var domain: String { get }
    var path: String { get }
}

extension Configuration {
    var urlScheme: URL { URL(string: "\(netProtocol)\(domain)\(path)")! }
}
