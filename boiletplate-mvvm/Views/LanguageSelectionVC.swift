//
//  LanguageSelectionVC.swift
//  FATIMA
//
//  Created by EDS on 14/07/2022.
//

import UIKit
import BEMCheckBox
import LanguageManager_iOS

class LanguageSelectionVC: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var englishCheckBox : BEMCheckBox!
    @IBOutlet weak var englishLabel : UILabel!
    
    @IBOutlet weak var arabicButton: UIButton!
    @IBOutlet weak var arabicCheckBox : BEMCheckBox!
    @IBOutlet weak var arabicLabel : UILabel!
    
    var selectedLanguage = "en" {
        didSet {
            if selectedLanguage == "en" || selectedLanguage.lowercased() == "english" {
                self.englishCheckBox.on = true
                self.arabicCheckBox.on = false
            } else if selectedLanguage == "ar" || selectedLanguage.lowercased() == "arabic" {
                self.englishCheckBox.on = false
                self.arabicCheckBox.on = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topView.round(corners: [.layerMinXMinYCorner,
                                     .layerMaxXMinYCorner],
                           radius: 10)
        self.alertView.round(corners: [.layerMinXMaxYCorner,
                                       .layerMaxXMaxYCorner],
                             radius: 10)
        self.titleLabel.text = HLocalized().selectlanguage
        if selectedLanguage == "en" || selectedLanguage.lowercased() == "english" {
            self.englishCheckBox.on = true
            self.arabicCheckBox.on = false
        } else if selectedLanguage == "ar" || selectedLanguage.lowercased() == "arabic" {
            self.englishCheckBox.on = false
            self.arabicCheckBox.on = true
        }
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.englishCheckBox.lineWidth = 1.0
        self.englishCheckBox.onCheckColor = HConstants.Theme.Colors.ColorWhite
        self.englishCheckBox.onFillColor = HConstants.Theme.Colors.AppColor
        self.englishCheckBox.onTintColor = HConstants.Theme.Colors.AppColor
        
        self.arabicCheckBox.lineWidth = 1.0
        self.arabicCheckBox.onCheckColor = HConstants.Theme.Colors.ColorWhite
        self.arabicCheckBox.onFillColor = HConstants.Theme.Colors.AppColor
        self.arabicCheckBox.onTintColor = HConstants.Theme.Colors.AppColor
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                           action: #selector (dismissVC))
        tapGestureRecognizer.delegate = self
        
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc private func dismissVC() {
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    @IBAction func didTapEnglishButton(_ sender: UIButton) {
        self.englishCheckBox.on = true
        self.arabicCheckBox.on = false
        LanguageManager.shared.setLanguage(language: .en, for: nil, viewControllerFactory: nil, animation: nil)
        if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            delegate.isLogin()
        }
    }
    
    @IBAction func didTapArabicButton(_ sender: UIButton) {
        self.englishCheckBox.on = false
        self.arabicCheckBox.on = true
        LanguageManager.shared.setLanguage(language: .ar, for: nil, viewControllerFactory: nil, animation: nil)
        if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            delegate.isLogin()
        }
    }
}
extension LanguageSelectionVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchLocation = touch.location(in: self.view)
        if touch.view == self.alertView || touch.view == self.englishButton || touch.view == self.arabicButton || touch.view == self.titleLabel || touch.view == self.topView {
            return false
        }
        return !alertView.frame.contains(touchLocation)
    }
}
