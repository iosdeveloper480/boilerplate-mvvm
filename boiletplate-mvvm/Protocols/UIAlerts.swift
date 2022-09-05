//
//  UIAlerts.swift
//  Asmaky
//
//  Created by EDS on 26/12/2021.
//

import Foundation
import UIKit

protocol UIAlerts {
    func showAlert(message: String,
                   okHandler: ((_ action: UIAlertAction) -> Void)?)
    func showAlert(message: String,
                   okHandler: ((_ action: UIAlertAction) -> Void)?,
                   cancelHandler: ((_ action: UIAlertAction) -> Void)?)
    func showAlert(title: String,
                   message: String,
                   okButtonTitle: String,
                   okHandler: ((_ action: UIAlertAction) -> Void)?)
}

extension UIAlerts where Self: UIViewController {
    func showAlert(message: String,
                   okHandler: ((_ action: UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "Oops",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .cancel,
                                      handler: okHandler))
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
    
    func showAlert(message: String,
                   okHandler: ((_ action: UIAlertAction) -> Void)? = nil,
                   cancelHandler: ((_ action: UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "Oops",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: HLocalized().yes,
                                      style: .default,
                                      handler: okHandler))
        
        alert.addAction(UIAlertAction(title: HLocalized().no,
                                      style: .cancel,
                                      handler: cancelHandler))
        
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
    
    func showAlert(title: String,
                   message: String,
                   okButtonTitle: String,
                   okHandler: ((_ action: UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okButtonTitle,
                                      style: .default,
                                      handler: okHandler))
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
}

extension UIViewController: UIAlerts {}
