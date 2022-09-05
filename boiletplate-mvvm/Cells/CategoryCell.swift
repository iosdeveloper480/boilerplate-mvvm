//
//  CategoryCell.swift
//  FATIMA
//
//  Created by EDS on 12/07/2022.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var custombackgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.setFont(style: .body2)
        self.titleLabel.textColor = .black
        
        self.custombackgroundView.backgroundColor = HConstants.Theme.Colors.backgroundColor
    }
    
    func cellDataSource(item: ExCategory) {
        self.titleLabel.text = item.name
        self.imageView.sd_setImage(with: URL(string: item.img!))
    }
    
//    func cellDataSource(profile: ProfileModel) {
//        self.titleLabel.text = profile.name
////        self.imageView.sd_setImage(with: URL(string: profile.image))
//        self.imageView.image = DUtility.shared.placeholder()
//        self.imageView.cornerRadius(cornerRadius: 75)
//        self.topConstraint.constant = 5
//        self.leadingConstraint.constant = 5
//        self.bottomConstraint.constant = 5
//        self.trailingConstraint.constant = 5
//        
//    }
}
