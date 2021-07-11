//
//  ItemsRouter.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/11/21.
//

import UIKit

protocol ItemRouterInput: class {
    static func loadItemsScreen()
    func moveToCart(navigationConroller:UINavigationController?)

}

class ItemsRouter:  ItemRouterInput{
    /**
     Method to set ItemsViewController as rootViewController
     */
    class func loadItemsScreen() {
        let sceneDelegate = SceneDelegate.sceneDelegate
        let presenter = ItemsPresenter(interactor: ItemsInteractor(), router: ItemsRouter())
        guard let window = sceneDelegate.window else { return }
        if let controller = ItemsViewController.controller(presenter: presenter) {
            let navigationController = UINavigationController(rootViewController: controller)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
    
    /**
     Method to show cart page
     */
    func moveToCart(navigationConroller: UINavigationController?) {
        if let controller = CartRouter.cartController() {
            navigationConroller?.pushViewController(controller,animated: true)
            navigationConroller?.setNavigationBarHidden(false, animated: false)
        }
       }
}
