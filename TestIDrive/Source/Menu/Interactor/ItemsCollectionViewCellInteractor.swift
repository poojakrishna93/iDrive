//
//  ItemsCollectionViewCellInteractor.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/10/21.
//

import UIKit

protocol ItemsCollectionViewCellInteractorInput : class {
    func getImage(url: String, completion: @escaping NetworkCompletionHandlers.ImageResponse)
}

class ItemsCollectionViewCellInteractor:  ItemsCollectionViewCellInteractorInput{
    
    private var apiService: MenuApiService?
    
    init() {
        apiService = MenuApiService()
    }
    
    /**
     Method to download Image
     */
    func getImage(url: String, completion: @escaping NetworkCompletionHandlers.ImageResponse) {
        if let cachedImage = ImageCacheManager.shared.getCachedImage(for: NSString(string: url)) {
            completion(cachedImage)
        } else {
            apiService?.getImage(for: url, completion: { (data, error) in
                if data != nil {
                    if let imageData = data as? Data, let image = UIImage(data: imageData) {
                        ImageCacheManager.shared.saveImageToCache(image, for: url as NSString)
                        completion(image)
                    } else {
                        completion(nil)
                    }
                }
            })
        }
    }
}
