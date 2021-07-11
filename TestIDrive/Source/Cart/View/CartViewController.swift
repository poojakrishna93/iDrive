//
//  CartViewController.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/11/21.
//

import UIKit

class CartViewController: BaseViewController {
    @IBOutlet weak var cartCollectionView: UICollectionView!
    private var presenter: CartPresenterInput?
    
    /**
     Method to create instance of controller
     */
    class func controller(presenter: CartPresenterInput?) -> CartViewController? {
        let storyboard = UIStoryboard(name: StoryBoardConstants.main, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: CartViewController.className) as? CartViewController
        controller?.presenter = presenter
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomNavigationBar(navigationBarTitle: StringConstants.myCart, navigationBarLeftButtonType: .BackArrow)
        cartCollectionView.delegate = self
        cartCollectionView.dataSource = self
        registerCells()
        presenter?.setup(output: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationbarForViewControllerHidden(false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        setNavigationbarForViewControllerHidden(true)
    }
    
    /**
     Method to register cell
     */
    private func registerCells() {
        cartCollectionView.register(UINib(nibName: ViewConstants.menuItemCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ViewConstants.menuItemCollectionViewCell)
    }
}

extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.carItemsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cartCollectionView.dequeueReusableCell(withReuseIdentifier: ViewConstants.menuItemCollectionViewCell, for: indexPath) as? MenuItemCollectionViewCell
        if let item = presenter?.itemAtIndex(indexPath.row) {
            cell?.configureCell(index: indexPath.row, imageUrl: item.image, title: item.name, price: item.price, showCart: false)
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 4)/2, height: 200)
    }
}

extension CartViewController: CartPresenterOutput {
    /**
     Method to load data to collectionView
     */
    func reloadData() {
        cartCollectionView.reloadData()
    }
    
    func showAlert(message: String) {
        
    }
}
