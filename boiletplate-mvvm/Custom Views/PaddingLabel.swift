//
//  PaddingLabel.swift
//  Asmaky
//
//  Created by mac on 14/11/2021.
//

import UIKit

@IBDesignable
class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 4.0
    @IBInspectable var bottomInset: CGFloat = 4.0
    @IBInspectable var leftInset: CGFloat = 4.0
    @IBInspectable var rightInset: CGFloat = 4.0
    
    var insets: UIEdgeInsets {
        get {
            return UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        }
        set {
            topInset = newValue.top
            leftInset = newValue.left
            bottomInset = newValue.bottom
            rightInset = newValue.right
        }
    }
    
    //    required init(withInsets top: CGFloat, _ bottom: CGFloat,_ left: CGFloat,_ right: CGFloat) {
    //        self.topInset = top
    //        self.bottomInset = bottom
    //        self.leftInset = left
    //        self.rightInset = right
    //        super.init(frame: CGRect.zero)
    //    }
    //
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
    
    func padding(top: CGFloat,
                 bottom: CGFloat,
                 left: CGFloat,
                 right: CGFloat) {
        self.topInset = top
        self.bottomInset = bottom
        self.leftInset = left
        self.rightInset = right
        self.layoutSubviews()
    }
}
