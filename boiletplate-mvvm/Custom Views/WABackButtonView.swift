//
//  WABackButtonView.swift
//  Asmaky
//
//  Created by EDS on 26/01/2022.
//

import Foundation
import UIKit
import LanguageManager_iOS

protocol WABackButtonViewDelegate: AnyObject {
    func didGoback()
}

class WABackButtonView: UIView {
    
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var button : UIButton!
    
    weak var delegate: WABackButtonViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if LanguageManager.shared.currentLanguage == .ar {
            self.imageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        } else {
            self.imageView.transform = .identity
        }
    }
    
    @IBAction func didGoback() {
        self.delegate?.didGoback()
    }
}
