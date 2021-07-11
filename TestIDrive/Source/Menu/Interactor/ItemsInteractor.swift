//
//  ItemsInteractor.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/9/21.
//

import Foundation
import RealmSwift

protocol ItemsInteractorInput : class {
    func setup(interactorOutput: ItemsInteractorOutput?)
    func getMenuItems()
    func addToCart (item: MenuItem)
}

protocol ItemsInteractorOutput : class {
    func didGetItems (success: Bool, items: MenuItemResponse?, error _:CustomError?)
    func AddedItemToCart (success: Bool, error :CustomError?)
}

extension ItemsInteractorOutput {
    func didGetItems (success _: Bool, error _:CustomError?) {}
    func AddedItemToCart (success _: Bool, error _:CustomError?) {}
}

class ItemsInteractor: ItemsInteractorInput {
    
    private weak var output: ItemsInteractorOutput?
    private var apiService: MenuApiService?
    private var jsonParser: JSONParser?
    
    init() {
        apiService = MenuApiService()
        jsonParser = JSONParser()
    }
    
    /**
     Method to setup properties
     */
    func setup(interactorOutput: ItemsInteractorOutput?) {
        output = interactorOutput
    }
    
    /**
     Method to get items to sell
     */
    func getMenuItems() {
        if Reachability.isConnectedToNetwork() {
            apiService?.getMenuItems(completion: { (data, error) in
                if data != nil {
                    // ----Parsing data after successful validations
                    self.jsonParser?.parseJsonData(dataFromAPI: data, type: MenuItemResponse.self) { [weak self] result in
                        switch result {
                        case .failure( _):
                            // ---Data parsing failed
                            self?.output?.didGetItems(success: false, items: nil, error: CustomError.parseError)
                        case .success(let response):
                            self?.output?.didGetItems(success: true, items: response, error: nil)
                            DispatchQueue.main.async {
                                DataBaseManager.shared.saveMenuItems(response)
                            }
                        }
                    }
                }else {
                    self.output?.didGetItems(success: false, error: error)
                }
            })
        }else {
            //fetch from database
            if let response = DataBaseManager.shared.cachedMenuResponse() {
                self.output?.didGetItems(success: true, items: response, error: nil)
            }else {
                self.output?.didGetItems(success: false, items: nil, error: CustomError.databaseError)
            }
        }
    }
    
    /**
     Method to add items to cart
     */
    func addToCart(item: MenuItem) {
        do {
            try DataBaseManager.shared.saveToCart(item: item)
            output?.AddedItemToCart(success: true, error: nil)
        } catch let error {
            output?.AddedItemToCart(success: false, error: CustomError.customMessage(message: error.localizedDescription, code: 1003))
        }
    }
    
}
