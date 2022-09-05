//
//  FavoriteCell.swift
//  FATIMA
//
//  Created by EDS on 13/07/2022.
//

import UIKit
import SDWebImage
import LanguageManager_iOS

protocol CartCellDelegate: AnyObject {
    func didTapDeleteButton(model: AnyHashable?)
}

class CartCell: UICollectionViewCell {
    
    @IBOutlet weak var custombackgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var crossButton: UIButton!
    
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var priceTextField: UITextField!
    
    private var price: Double = 1.0
    weak var delegate: CartCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleLabel.setFont(style: .body2)
//        self.colorLabel.setFont(style: .body2)
        self.sizeLabel.setFont(style: .body2)
        self.priceLabel.setFont(style: .body2)
        self.imageView.round(corners: HConstants.Theme.Corners.all, radius: 5)
        self.imageView.image = DUtility.shared.placeholder()
        
//        self.priceView.round(corners: HConstants.Theme.Corners.all, radius: 5)
        self.priceView.border(width: 1, color: HConstants.Theme.Colors.lightGrayColor, maskedCorners: HConstants.Theme.Corners.all, radius: 5)
        self.priceTextField.text = "\(self.price)"
        self.priceTextField.textColor = HConstants.Theme.Colors.ColorBlack
        
        self.custombackgroundView.backgroundColor = HConstants.Theme.Colors.backgroundColor
    }
    
    @IBAction func didTapCrossButton(_ sender: UIButton) {
        self.delegate?.didTapDeleteButton(model: nil)
    }
    @IBAction func didTapPlusButton(_ sender: UIButton) {
        self.price = self.price + 1.0
        self.priceTextField.text = "\(self.price)"
    }
    @IBAction func didTapMinusButton(_ sender: UIButton) {
        if self.price != 1.0 {
            self.price = self.price - 1.0
            self.priceTextField.text = "\(self.price)"
        }
    }
}
