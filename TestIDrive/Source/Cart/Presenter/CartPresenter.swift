//
//  CartPresenter.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/11/21.
//

import Foundation

protocol CartPresenterInput : class {
    func setup(output: CartPresenterOutput?)
    func carItemsCount() -> Int
    func itemAtIndex(_ row: Int) -> MenuItem?
}

protocol CartPresenterOutput : class {
    func reloadData()
    func showAlert(message: String)
}

extension CartPresenterOutput {
    func reloadData(){}
    func showAlert(Message: String){}
}

class CartPresenter: CartPresenterInput {
    private var interactor: CartInteractorInput?
    private weak var output: CartPresenterOutput?
    private var cartItems: CartItemsResponse?
    private var router: CartRouterInput?
    
    init(interactor: CartInteractorInput?, router: CartRouterInput?) {
        self.interactor = interactor
        self.router = router
    }
    
    func setup(output: CartPresenterOutput?) {
        self.output = output
        interactor?.setup(interactorOutput: self)
        getCartItems()
    }
    
    func carItemsCount() -> Int {
        cartItems?.itemsList.count ?? 0
    }
    
    func itemAtIndex(_ row: Int) -> MenuItem? {
        if row < cartItems?.itemsList.count ?? 0 && row >= 0 {
            return cartItems?.itemsList[row]
        }
       return nil
    }
    
    /**
     Method to get cart items from database
     */
    private func getCartItems(){
        interactor?.getCartItems()
    }
    
}

extension CartPresenter: CartInteractorOutput {
    
    /**
     Methdo to handle cart data from database
     */
    func didGetItems(success: Bool, items: CartItemsResponse?, error: CustomError?) {
        if success {
            cartItems = items
            output?.reloadData()
        }else{
            output?.showAlert(message: error?.localizedDescription ?? ErrorMessageConstants.somethingWentWrong)
        }
    }
    
}
