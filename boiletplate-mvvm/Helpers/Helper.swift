//
//  Helper.swift
//  Asmaky
//
//  Created by mac on 14/11/2021.
//

import Foundation
import UIKit
import LanguageManager_iOS
import IQKeyboardManagerSwift

class Helper {
    //    class func getLanguage() -> String {
    //        if let lang = UserDefaults.standard.value(forKey: "language") as? String {
    //            return lang
    //        }
    //        return "en"
    //    }
    //
    //    class func getLanguageName() -> String {
    //        if self.getLanguage() == "ar" {
    //            return "arabic".localized
    //        }
    //        return "english".localized
    //    }
    //
    //    class func getLanguageNumber() -> String {
    //        if self.getLanguage() == "ar" {
    //            return "0"
    //        }
    //        return "1"
    //    }
    class func getFirebaseUID() -> String {
        //        if isLoggin(){
        if let uid = UserDefaults.standard.value(forKey: "FirebaseUID") as? String {
            return uid
        }
        //        }
        return ""
    }
    
    //UserPhone
    class func getUserPhone() -> String {
        if let phone = UserDefaults.standard.value(forKey: "UserPhone") as? String {
            return phone
        }
        return ""
    }
    
    //User Email
    class func getUserEmail() -> String {
        if let email = UserDefaults.standard.value(forKey: "Email") as? String {
            return email
        }
        return " "
    }
    
    //Username
    class func getUserName() -> String {
        if let name = UserDefaults.standard.value(forKey: "Username") as? String {
            return name
        }
        return ""
    }
    
    class func getFCMToken() -> String {
        if let token = UserDefaults.standard.value(forKey: "fcmToken") as? String {
            return token
        }
        return ""
    }
    
    class func isLoggin()->Bool{
        if let loggedIn = UserDefaults.standard.value(forKey: "isLoggedIn") as? Bool {
            return loggedIn
        }
        return false
    }
    
    class func logout() {
        UserDefaults.standard.set("", forKey: "FirebaseUID")
        UserDefaults.standard.set("", forKey: "UserPhone")
        UserDefaults.standard.set("", forKey: "Email")
        UserDefaults.standard.set("", forKey: "Username")
        UserDefaults.standard.set("", forKey: "fcmToken")
        UserDefaults.standard.set("", forKey: "isLoggedIn")
    }
    
    class func getJSONString(for dict: [String: Any]) -> String? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []), let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString.replacingOccurrences(of: "\\", with: "")
        }
        return nil
    }
    class func getBundleVersionString() -> String {
        return Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    }
}

extension Helper {
    class func setLanguage(from language: Languages) {
        
        LanguageManager.shared.setLanguage(language: language)
        
        if language == .ar {
            UIView.userInterfaceLayoutDirection(for: .forceRightToLeft)
            UIWindow.appearance().semanticContentAttribute = .forceRightToLeft
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UILabel.appearance().semanticContentAttribute = .forceRightToLeft
            UILabel.appearance().semanticContentAttribute = .forceRightToLeft
            UITextView.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().textAlignment = .right
            UIButton.appearance().semanticContentAttribute = .forceRightToLeft
            UICollectionView.appearance().semanticContentAttribute = .forceRightToLeft
            UITableView.appearance().semanticContentAttribute = .forceRightToLeft
            UITableViewCell.appearance().semanticContentAttribute = .forceRightToLeft
            UICollectionViewCell.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.userInterfaceLayoutDirection(for: .forceLeftToRight)
            UIWindow.appearance().semanticContentAttribute = .forceLeftToRight
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UILabel.appearance().semanticContentAttribute = .forceLeftToRight
            UITextView.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance().textAlignment = .left
            UIButton.appearance().semanticContentAttribute = .forceLeftToRight
            UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
            UITableView.appearance().semanticContentAttribute = .forceLeftToRight
            UITableViewCell.appearance().semanticContentAttribute = .forceLeftToRight
            UICollectionViewCell.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = HLocalized().done
        
        UIApplication.shared.windows[0].rootViewController = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateInitialViewController()
    }
}

// MARK: - Validation
extension Helper {
    class func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    
    class func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
