//
//  ItemsViewController.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/1/21.
//

import UIKit

class ItemsViewController: BaseViewController {
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    
    private var presenter: ItemsPresenterInput?
    
    /**
     Method to create instance of controller
     */
    class func controller(presenter: ItemsPresenter?) -> ItemsViewController? {
        let storyboard = UIStoryboard(name: StoryBoardConstants.main, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: ItemsViewController.className) as? ItemsViewController
        controller?.presenter = presenter
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomNavigationBar(navigationBarTitle: StringConstants.menu,navigationBarLeftButtonType: NavbarLeftButton.None, navigationBarRightButtonType: .cart)
        itemsCollectionView.delegate = self
        itemsCollectionView.dataSource = self
        registerCells()
        presenter?.setup(presenterOutput: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationbarForViewControllerHidden(false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    /**
     Method to register cell
     */
    private func registerCells() {
        itemsCollectionView.register(UINib(nibName: ViewConstants.menuItemCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ViewConstants.menuItemCollectionViewCell)
    }
    
    override func navigationBarRightButtonCustomAction() {
        presenter?.moveToCartPage(navigationController: self.navigationController)
    }

}

extension ItemsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MenuItemCollectionViewCelldelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.menuItemsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = itemsCollectionView.dequeueReusableCell(withReuseIdentifier: ViewConstants.menuItemCollectionViewCell, for: indexPath) as? MenuItemCollectionViewCell
        cell?.cellDelegate = self
        if let item = presenter?.itemAtIndex(indexPath.row) {
            cell?.configureCell(index: indexPath.row, imageUrl: item.image, title: item.name, price: item.price)
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 4)/2, height: 200)
    }

    /**
     Delegate method to handle cart icon click
     */
    func didClickCartButton(for index: Int?) {
        if let index = index {
            presenter?.addToCart(for: index)
        }
    }
    
}

extension ItemsViewController: ItemsPresenterOutput {
    
    /**
     Method to load data to collectionView
     */
    func reloadData() {
        DispatchQueue.main.async {
            self.itemsCollectionView.reloadData()
        }
    }
    
    /**
     Method to show alert on controller
     */
    func showAlert(message: String) {
        DispatchQueue.main.async {
            self.showAlert(message)
        }
    }
}

