//
//  Localizable.swift
//  app
//
//  Created by mac on 15/09/2020.
//  Copyright © 2020 Ahmed Abdalla. All rights reserved.
//
import Foundation
import UIKit

//MARK: Label Translation Key
extension UILabel {
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if self.adjustsFontSizeToFitWidth {
            overrideFontSizes(fontSize: self.font.pointSize)
        }
    }
    
    @IBInspectable
    var translationKey: String {
        get {
            return self.translationKey
        }
        set {
            self.text = newValue.localiz()//newValue.localiz()
            
        }
    }
    func overrideFontSizes(fontSize:CGFloat){
        let currentFontName = self.font.fontName
        var calculatedFont: UIFont?
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        calculatedFont = UIFont(name: currentFontName, size: fontSize * (height / 900.0))
        self.font = calculatedFont
        
        
    }
    
}

//MARK: Button Translation Key
extension UIButton {
    @IBInspectable
    var translationKey: String {
        get {
            return self.translationKey
        }
        set {
            self.setTitle(newValue.localiz(), for: .normal)
            
        }
    }
    
    @IBInspectable
    var translationSelectedKey: String {
        get {
            return self.translationKey
        }
        set {
            self.setTitle(newValue.localiz(), for: .selected)
            
        }
    }
    
    @IBInspectable
    var translationHighlightedKey: String {
        get {
            return self.translationKey
        }
        set {
            self.setTitle(newValue.localiz(), for: .highlighted)
            
        }
    }
    
    @IBInspectable
    var translationDisabledKey: String {
        get {
            return self.translationKey
        }
        set {
            self.setTitle(newValue.localiz(), for: .disabled)
            
        }
    }
    
//    func cornerRadius(cornerRadius: CGFloat) {
//        self.layer.cornerRadius = cornerRadius
//    }
//    
//    func border(width: CGFloat, color: UIColor, cornerRadius: CGFloat = 0.0) {
//        self.layer.borderWidth = width
//        self.layer.borderColor = color.cgColor
//        self.cornerRadius(cornerRadius: cornerRadius)
//    }
}

//MARK: TextField Translation Key
extension UITextField {
    
    func localize() {
        self.placeholder = self.placeholder?.localiz()
    }
    
    open override func didMoveToSuperview() {
        //    if let font = self.font { overrideFontSizes(fontSize: font.pointSize) }
        
        self.placeholder = self.placeholder?.localiz()
        super.didMoveToSuperview()
        self.tintColor = HConstants.Theme.Colors.AppColor
    }
    
    @IBInspectable
    var translationPlaceHolderKey: String {
        get {
            return self.translationPlaceHolderKey
        }
        set {
            self.placeholder = newValue.localiz()
        }
    }
    
    @IBInspectable
    var translationKey: String {
        get {
            return self.translationKey
        }
        set {
            //            self.text = newValue.localiz()
            
        }
    }
    
    func overrideFontSizes(fontSize:CGFloat){
        if let currentFontName = self.font?.fontName {
            var calculatedFont: UIFont?
            let bounds = UIScreen.main.bounds
            let height = bounds.size.height
            calculatedFont = UIFont(name: currentFontName, size: fontSize * (height / 900.0))
            self.font = calculatedFont
            self.layoutIfNeeded()
        }
        
    }
}

//MARK: TextView Translation Key
extension UITextView {
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let font = self.font { overrideFontSizes(fontSize: font.pointSize) }
        self.tintColor = HConstants.Theme.Colors.AppColor
    }
    
    @IBInspectable
    var translationKey: String {
        get {
            return self.translationKey
        }
        set {
            self.text = newValue.localiz()
            
        }
    }
    
    func overrideFontSizes(fontSize:CGFloat){
        if let currentFontName = self.font?.fontName {
            var calculatedFont: UIFont?
            let bounds = UIScreen.main.bounds
            let height = bounds.size.height
            calculatedFont = UIFont(name: currentFontName, size: fontSize * (height / 900.0))
            self.font = calculatedFont
        }
        
    }
}

//MARK: UITabBarItem Translation Key
extension UITabBarItem {
    @IBInspectable
    var translationTitleKey: String {
        get {
            return self.translationTitleKey
        }
        set {
            self.title = newValue.localiz()
        }
    }
}

