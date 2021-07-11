//
//  ItemsPresenter.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/9/21.
//

import UIKit

protocol ItemsPresenterInput : class {
    func setup(presenterOutput: ItemsPresenterOutput?)
    func menuItemsCount() -> Int
    func itemAtIndex(_ row: Int) -> MenuItem?
    func addToCart (for index: Int)
    func moveToCartPage(navigationController: UINavigationController?)
}

protocol ItemsPresenterOutput : class {
    func reloadData()
    func showAlert(message: String)
}

extension ItemsPresenterOutput {
    func reloadData(){}
    func showAlert(Message: String){}
}

class ItemsPresenter: ItemsPresenterInput {
    
    private var interactor: ItemsInteractorInput?
    private weak var output: ItemsPresenterOutput?
    private var menuItems: MenuItemResponse?
    private var router: ItemRouterInput?
    
    init(interactor: ItemsInteractorInput?, router: ItemRouterInput?) {
        self.interactor = interactor
        self.router = router
    }
    
    /**
     Method to setup properties
     */
    func setup(presenterOutput: ItemsPresenterOutput?) {
        output = presenterOutput
        interactor?.setup(interactorOutput: self)
        getMenuItems()
    }
    
    /**
     Method to get the items count
     */
    func menuItemsCount() -> Int {
        return menuItems?.itemsList.count ?? 0
    }
    
    /**
     Method to get item at index
     */
    func itemAtIndex(_ row: Int) -> MenuItem? {
        if row < menuItems?.itemsList.count ?? 0 && row >= 0 {
            return menuItems?.itemsList[row]
        }
       return nil
    }
    
    /**
     Method to get menuItems from Service
     */
    func getMenuItems() {
        interactor?.getMenuItems()
    }
    
    /**
     Method to add item to cart
     */
    func addToCart(for index: Int) {
        if let item = itemAtIndex(index) {
            interactor?.addToCart(item: item)
        }
    }
    
    /**
     Method to show cart page
     */
    func moveToCartPage(navigationController: UINavigationController?) {
        router?.moveToCart(navigationConroller: navigationController)
    }
    
}

extension ItemsPresenter: ItemsInteractorOutput {
    /**
     Method to handle items from api
     */
    func didGetItems(success: Bool, items: MenuItemResponse?, error: CustomError?) {
        if success {
            menuItems = items
            output?.reloadData()
        }else{
            output?.showAlert(message: error?.localizedDescription ?? ErrorMessageConstants.somethingWentWrong)
        }
    }
    
    /**
     Method to handle ui after adding iitem to cart
     */
    func AddedItemToCart(success: Bool, error: CustomError?) {
        output?.showAlert(message: success == true ? StringConstants.cartSuccessMessage : error?.localizedDescription ?? "")
    }
    
}
