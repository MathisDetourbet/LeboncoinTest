//
//  ImageCache.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 16/10/20.
//

import UIKit

final class ImageCache {
    
    private lazy var cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = Configuration.imagesCountLimit
        cache.totalCostLimit = Configuration.totalMemoryLimit
        return cache
    }()
    
    // MARK: - Store and retrieve image
    func storeImageInCache(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url.absoluteString as NSString)
    }
    
    func retrieveImageFromCache(with url: URL) -> UIImage? {
        return cache.object(forKey: url.absoluteString as NSString)
    }
}


// MARK: - Image cache configuration
extension ImageCache {
    
    enum Configuration {
        static let imagesCountLimit = 100
        static let totalMemoryLimit = 1024 * 1024 * 100
    }
}
