//
//  CartInteractor.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/11/21.
//

import Foundation

protocol CartInteractorInput : class {
    func getCartItems()
    func setup(interactorOutput: CartInteractorOutput?)
}

protocol CartInteractorOutput : class {
    func didGetItems (success: Bool, items: CartItemsResponse?, error _:CustomError?)
}

extension CartInteractorOutput {
    func didGetItems (success: Bool, items: CartItemsResponse?, error _:CustomError?) {}
}

class CartInteractor: CartInteractorInput{
    
    private weak var output: CartInteractorOutput?
    
    init() {
    }
    
    /**
     Method to setup properties
     */
    func setup(interactorOutput: CartInteractorOutput?) {
        output = interactorOutput
    }
    
    /**
     Method to get cart items from database
     */
    func getCartItems() {
        if let cartItems = DataBaseManager.shared.cachedCartItems() {
            output?.didGetItems(success: true, items: cartItems, error: nil)
        }else {
            output?.didGetItems(success: false, items: nil, error: CustomError.databaseError)
        }
    }
}
