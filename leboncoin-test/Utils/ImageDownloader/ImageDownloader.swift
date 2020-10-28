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
    private static let successCodeRange = 200..<300
    
    static func download(from url: URL, completion: @escaping (UIImage?, HTTPError?) -> Void) -> URLSessionTask? {
        if let cachedImage = cache.retrieveImageFromCache(with: url) {
            completion(cachedImage, nil)
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // HTTP request will always respond with a response of type HTTPURLResponse
            let httpResponse = response as? HTTPURLResponse
            
            // Check if request failed
            if let error = error, let httpResponse = httpResponse {
                if !ImageDownloader.successCodeRange.contains(httpResponse.statusCode) {
                    completion(nil, HTTPError.makeFromHTTPURLResponse(httpResponse))
                } else {
                    completion(nil, HTTPError.makeFromNSError(error as NSError))
                }
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
        
        return task
    }
}
