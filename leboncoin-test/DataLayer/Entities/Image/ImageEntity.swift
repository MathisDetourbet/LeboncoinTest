//
//  ImageEntity.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 15/10/20.
//

import Foundation

struct ImageEntity {
    let smallImageUrl: URL?
    let largeImageUrl: URL?
    let defaultImageName: String
}

extension ImageEntity: ModelInitializable {
    init(from model: ImageModel) {
        self.smallImageUrl = URL(string: model.small ?? "")
        self.largeImageUrl = URL(string: model.thumb ?? "")
        self.defaultImageName = "default_ad_image"
    }
}
