//
//  ImageCacheManager.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/10/21.
//

import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let imageCache = NSCache<NSString, UIImage>()
    
    /**
     Method to get image from cache
     @param: url - path of the image to fetch
     @return UIImage instance
     */
    func getCachedImage(for url: NSString) -> UIImage? {
        if let cachedImage = imageCache.object(forKey: url){
            return cachedImage
        }
        return nil
    }
    
    /**
     Method to save image to cache
     @param: url - path of the image to fetch
     @param image image to save
     */
    func saveImageToCache(_ image: UIImage?, for url: NSString?) {
        guard let img = image, let urlString = url else {
            return
        }
        imageCache.setObject(img, forKey: urlString)
    }
}
