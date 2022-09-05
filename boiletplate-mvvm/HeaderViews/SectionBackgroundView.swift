//
//  SectionBackgroundView.swift
//  Asmaky Shop
//
//  Created by EDS on 27/02/2022.
//

import UIKit

class SectionBackgroundView: UICollectionReusableView {

    @IBOutlet weak var custombackgroundView: UIView!
    
    static var reuseIdentifier = "SectionBackgroundView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func viewDataSource(corners: CACornerMask, radius: CGFloat) {
        self.custombackgroundView.round(corners: corners, radius: radius)
    }
}
