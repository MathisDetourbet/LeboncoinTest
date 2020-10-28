//
//  UIImageView+ImageDownloader.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 16/10/20.
//

import UIKit

extension UIImageView {
    
    func downloadImageFromURL(_ url: URL?, with placeholderImage: UIImage? = nil) -> URLSessionTask? {
        DispatchQueue.main.async {
            self.image = placeholderImage
        }
        
        guard let url = url else {
            return nil
        }
        
        return ImageDownloader.download(from: url) { [weak self] (downloadedImage, httpError) in
            guard let self = self, httpError == nil else {
                return
            }

            DispatchQueue.main.async {
                self.image = downloadedImage
            }
        }
    }
}
