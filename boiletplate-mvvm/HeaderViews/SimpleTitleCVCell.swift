//
//  SimpleTitleCVCell.swift
//  FATIMA
//
//  Created by EDS on 12/07/2022.
//

import UIKit
import LanguageManager_iOS

protocol SimpleTitleCVCellDelegate: AnyObject {
    
}

class SimpleTitleCVCell: UICollectionReusableView {
    
    @IBOutlet weak var custombackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: SimpleTitleCVCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if LanguageManager.shared.currentLanguage == .ar {
            self.titleLabel.textAlignment = .right
        } else {
            self.titleLabel.textAlignment = .left
        }
        self.titleLabel.setFont(style: .title2)
        
        self.custombackgroundView.backgroundColor = HConstants.Theme.Colors.backgroundColor
    }
    
    func cellDataSource(title: String) {
        self.titleLabel.text = title
    }
    
    func cellDataSource(norecord: String) {
        self.titleLabel.text = norecord
        self.custombackgroundView.backgroundColor = HConstants.Theme.Colors.backgroundColor
    }
    
    func cellDataSourceCart(title: String) {
        self.titleLabel.text = title
        self.titleLabel.textColor = HConstants.Theme.Colors.ColorGray
        self.backgroundColor = HConstants.Theme.Colors.backgroundColor
        self.custombackgroundView.backgroundColor = HConstants.Theme.Colors.backgroundColor
    }
    
    func cellDataSourceWhite(title: String) {
        self.titleLabel.text = title
        self.titleLabel.textColor = HConstants.Theme.Colors.ColorBlack
        self.backgroundColor = HConstants.Theme.Colors.ColorWhite
        self.custombackgroundView.backgroundColor = HConstants.Theme.Colors.backgroundColor
    }
    
    @IBAction func didTapButton(_ sender: UIButton) {
        
    }
}
