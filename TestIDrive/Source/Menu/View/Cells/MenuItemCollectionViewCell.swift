//
//  MenuItemCollectionViewCell.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/9/21.
//

import UIKit

protocol MenuItemCollectionViewCelldelegate: class {
    func didClickCartButton(for index: Int?)
}

class MenuItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemBackgroundView: UIView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cartButton: UIButton!
    
    var index: Int?
    weak var cellDelegate: MenuItemCollectionViewCelldelegate?
    private var presenter: ItemCollectionViewCellPresenterInput?

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
        presenter = ItemCollectionViewCellPresenter()
    }
    
    /**
     Method to set up ui elements
     */
    private func setUpUI() {
        itemBackgroundView.backgroundColor = UIColor.iDriveLightGray
        titleLabel.textColor = UIColor.iDriveBlack
        priceLabel.textColor = UIColor.iDrivePrimary
        cartButton.applyShadow(cornerRadius: 22)
    }
    
    /**
     Method to configure cell with data
     */
    func configureCell(index: Int?, imageUrl: String?, title: String?, price:String?, showCart: Bool = true){
        self.index = index
        titleLabel.text = title
        priceLabel.text = price
        itemImageView.image = #imageLiteral(resourceName: "ic_placeholder")
        if showCart {
            cartButton.isHidden = false
        } else {
            cartButton.isHidden = true
        }
        if let url = imageUrl {
            presenter?.loadImage(url: url, completion: { [weak self] image in
                if image != nil {
                    DispatchQueue.main.async {
                        self?.itemImageView.image = image
                    }
                    
                }
            })
        }
    }
    
    /**
     Method to handle cart button action
     */
    @IBAction func cartButtonClicked(_ sender: Any) {
        cellDelegate?.didClickCartButton(for: index)
    }

}
