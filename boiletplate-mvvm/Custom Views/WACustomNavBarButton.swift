//
//  WACustomNavBarButton.swift
//  Asmaky
//
//  Created by EDS on 27/02/2022.
//

import UIKit
import LanguageManager_iOS

protocol WACustomNavBarButtonDelegate: AnyObject {
    func didTapNavBarButton()
}

class WACustomNavBarButton: UIView {

    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var backgroundView : UIView!
    @IBOutlet weak var button : UIButton!
    
    weak var delegate: WACustomNavBarButtonDelegate?
    private var isDeleting = true
    private var isAddButton = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if LanguageManager.shared.currentLanguage == .ar {
            self.imageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
    
    @IBAction func didTapTrashButton(_ sender: UIButton) {
        self.delegate?.didTapNavBarButton()
    }
    
    func setTint(color: UIColor) {
        self.imageView.tintColor = color
    }
}
