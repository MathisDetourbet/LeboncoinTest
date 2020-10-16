//
//  ImageDownloader.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 16/10/20.
//

import UIKit

final class ImageDownloader {
    
    static var shared = ImageDownloader()
    
    private static var cache = ImageCache()
    
    static func download(from url: URL, completion: @escaping (UIImage?, HTTPError?) -> Void) {
        if let cachedImage = cache.retrieveImageFromCache(with: url) {
            completion(cachedImage, nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, HTTPError.makeFromNSError(error as NSError))
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil, .noResponseData)
                return
            }
            
            cache.storeImageInCache(image, for: url)
            completion(image, nil)
        }
        
        task.resume()
    }
}
