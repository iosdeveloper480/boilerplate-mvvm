//
//  SliderCell.swift
//  FATIMA
//
//  Created by EDS on 12/07/2022.
//

import UIKit
import SDWebImage

class SliderCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellDataSource(model: ExSlider) {
        
        self.layoutSubviews()
        self.layoutIfNeeded()
        self.imageView.layoutSubviews()
        self.imageView.layoutIfNeeded()
        self.backgroundColor = .white
        self.imageView.round(corners: HConstants.Theme.Corners.bottomRightBottomLeft,
                             radius: 20)
        self.imageViewBottomConstraint.constant = 0
        self.imageViewTopConstraint.constant = 0
        self.imageView.shadow(shadowColor: HConstants.Theme.Colors.lightGrayColor,
                              shadowOffset: CGSize(width: 0,
                                                   height: 1),
                              shadowRadius: HConstants.Theme.Radius.shadowRadius,
                              shadowOpacity: 1,
                              maskedCorners: HConstants.Theme.Corners.bottomRightBottomLeft)
        if let img = model.img, !img.isEmpty {
            self.imageView.sd_setImage(with: URL(string: img), placeholderImage: DUtility.shared.gifLandscapeLoader(), options: .waitStoreCache) { image, error, cache, url in
                if image == nil {
                    self.imageView.image = UIImage(named: "placeholder")
                }
            }
        } else {
            self.imageView.image = UIImage(named: "placeholder")
        }
    }
}
