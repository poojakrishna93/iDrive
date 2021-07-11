//
//  ItemCollectionViewCellPresenter.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/10/21.
//

import Foundation

protocol ItemCollectionViewCellPresenterInput : class {
    func loadImage(url: String, completion: @escaping NetworkCompletionHandlers.ImageResponse)
}

class ItemCollectionViewCellPresenter: ItemCollectionViewCellPresenterInput {
    private var interactor: ItemsCollectionViewCellInteractorInput?
    
    init() {
        interactor = ItemsCollectionViewCellInteractor()
    }
    
    /**
     Method to download Image
     */
    func loadImage(url: String, completion: @escaping NetworkCompletionHandlers.ImageResponse) {
        self.interactor?.getImage(url: url, completion: { image in
            completion(image)
        })
    }
    
}
