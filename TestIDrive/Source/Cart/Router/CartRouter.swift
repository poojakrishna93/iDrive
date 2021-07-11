//
//  CartRouter.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/11/21.
//

import Foundation

protocol CartRouterInput: class {
    static func cartController() -> CartViewController?

}

class CartRouter: CartRouterInput {
    
    init() {
        
    }
    
    /**
     Method to get cart controller
     */
    static func cartController() -> CartViewController? {
        let presenter = CartPresenter(interactor: CartInteractor(), router: CartRouter())
        return CartViewController.controller(presenter: presenter)
    }
}
