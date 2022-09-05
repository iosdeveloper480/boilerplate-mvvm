//
//  UIStoryboard.swift
//  Asmaky
//
//  Created by mac on 14/11/2021.
//

import UIKit

protocol Storyboarded {
    static func initialize(with: StoryboardNames) -> Self
}
extension Storyboarded where Self: UIViewController {
    static func initialize(with: StoryboardNames) -> Self {
        let storyboard = UIStoryboard(name: with.rawValue,
                                      bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: Self.self)) as! Self
    }
}

enum StoryboardNames: String {
    case main = "Main",
         profile = "Profile",
         favorite = "Favorite",
         utility = "Utility",
         notification = "Notification",
         settings = "Settings",
         customControls = "CustomControls",
         orders = "Orders",
         home = "Home",
         cart = "Cart",
         shop = "Shop",
         address = "Address"
}
