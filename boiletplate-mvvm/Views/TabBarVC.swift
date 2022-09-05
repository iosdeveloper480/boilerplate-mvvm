//
//  TabBarVC.swift
//  FATIMA
//
//  Created by EDS on 11/07/2022.
//

import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    //MARK: Properties
    weak var loginDelegate: LoginProtocol?
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.navigationController?.setStatusBar(backgroundColor: HConstants.Theme.Colors.AppColor)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let homeVC = HomeVC.initialize(with: .home)
        let homeIcon = UITabBarItem(title: nil, image: UIImage(named: "home"), selectedImage: UIImage(named: "home.fill"))
        homeIcon.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
        homeIcon.title = ""
        homeVC.tabBarItem = homeIcon
        let homeNavVC = UINavigationController(rootViewController: homeVC)
        
        let controllers = [homeNavVC]
        self.viewControllers = controllers
    }
    
    //MARK: Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
}

class TabBarNavVC: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    weak var loginDelegate: LoginProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStatusBar(backgroundColor: HConstants.Theme.Colors.AppColor)
        self.delegate = self
        self.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setStatusBar(backgroundColor: HConstants.Theme.Colors.AppColor)
    }
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        navigationController.view.semanticContentAttribute = UIView.isRightToLeft() ? .forceRightToLeft : .forceLeftToRight
        navigationController.navigationBar.semanticContentAttribute = UIView.isRightToLeft() ? .forceRightToLeft : .forceLeftToRight
    }
    //  Checking if the viewController is last, if not disable the gesture
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.viewControllers.count > 1 {
            return true
        }
        return false
    }
}
extension TabBarNavVC: LoginProtocol {
    func loginSuccessfully() {
        self.loginDelegate?.loginSuccessfully()
    }
    func logout() {
        self.loginDelegate?.logout()
    }
}

extension UIView {
    static func isRightToLeft() -> Bool {
        return UIView.appearance().semanticContentAttribute == .forceRightToLeft
    }
}
