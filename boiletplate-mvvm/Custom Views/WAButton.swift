//
//  WAButton.swift
//  Asmaky
//
//  Created by EDS on 20/06/2022.
//

import UIKit

class WAButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? HConstants.Theme.Colors.buttonPrimaryColor : HConstants.Theme.Colors.ColorWhite.withAlphaComponent(0.3)
            self.setTitleColor(HConstants.Theme.Colors.ColorBlack, for: .highlighted)
        }
    }
}
