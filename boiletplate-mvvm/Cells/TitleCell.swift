//
//  TitleCell.swift
//  FATIMA
//
//  Created by EDS on 13/07/2022.
//

import UIKit
import LanguageManager_iOS

class TitleCell: UICollectionViewCell {
    
    @IBOutlet weak var custombackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.setFont(style: .body2)
        
        self.custombackgroundView.backgroundColor = HConstants.Theme.Colors.backgroundColor
    }
    
    func cellDataSource(model: String) {
//        self.titleLabel.text = model.title
//        self.titleLabel.textAlignment = .right
//        self.custombackgroundView.round(corners: HConstants.Theme.Corners.topRightBottomRight, radius: 6)
//        if model.isSelected {
//            self.custombackgroundView.backgroundColor = HConstants.Theme.Colors.ColorWhite
//        } else {
//            self.custombackgroundView.backgroundColor = HConstants.Theme.Colors.backgroundColor
//        }
    }
}
