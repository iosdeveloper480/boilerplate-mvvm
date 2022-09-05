//
//  HomeVC.swift
//  FATIMA
//
//  Created by EDS on 11/07/2022.
//

import UIKit
import LanguageManager_iOS

class HomeVC: UIViewController {
    
    //MARK: Properties
    weak var loginDelegate: LoginProtocol?
    
    //MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        let viewModel = HomeViewModel(collectionView: self.collectionView)
        viewModel.delegate = self
        self.navigationController?.setStatusBar(backgroundColor: HConstants.Theme.Colors.AppColor)
        self.view.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        self.tabBarController?.tabBar.items?[0].title = ""
    }
}
extension HomeVC: HomeViewModelDelegate {
    func willLoad() {
        
    }
    func didLoad() {
        
    }
    func didSelectItem(at indexPath: IndexPath) {
        
    }
}

class HomeNavVC: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
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
extension HomeNavVC: LoginProtocol {
    func loginSuccessfully() {
        self.loginDelegate?.loginSuccessfully()
    }
    func logout() {
        self.loginDelegate?.logout()
    }
}
