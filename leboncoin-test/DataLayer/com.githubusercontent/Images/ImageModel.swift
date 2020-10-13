//
//  ImageModel.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 13/10/20.
//

import Foundation

struct ImageModel {
    let small: String
    let thumb: String
}

extension ImageModel: Decodable {
    enum ImageModelKeys: String, CodingKey {
        case small, thumb
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ImageModelKeys.self)
        self.small = try container.decode(String.self, forKey: .small)
        self.thumb = try container.decode(String.self, forKey: .thumb)
    }
}
