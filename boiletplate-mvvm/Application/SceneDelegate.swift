//
//  SceneDelegate.swift
//  FATIMA
//
//  Created by EDS on 11/07/2022.
//

import UIKit
import Firebase
import LanguageManager_iOS
import SwiftyJSON

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
//        FirebaseApp.configure()
        LanguageManager.shared.defaultLanguage = .en
        
        
        self.isLogin()
    }
    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

extension SceneDelegate: LoginProtocol {
    func isLogin() {
        if !UserModel.isLoggedIn() {
            self.loginSuccessfully()
        } else {
            self.logout()
        }
    }
    func loginSuccessfully() {
        let tabbarVC = TabBarVC.initialize(with: .home)
        tabbarVC.loginDelegate = self
        self.window?.rootViewController = tabbarVC
//        let tabbarNavVC = TabBarNavVC.initialize(with: .home)
//        tabbarNavVC.loginDelegate = self
//        self.window?.rootViewController = tabbarNavVC
    }
    
    func logout() {
        let loginVC = LoginVC.initialize(with: .main)
        loginVC.loginDelegate = self
        let navigationController = UINavigationController(rootViewController: loginVC)
        self.window?.rootViewController = navigationController
    }
    
    func languageChanged() {
        let loginVC = LoginVC.initialize(with: .main)
        loginVC.loginDelegate = self
        let navVC = UINavigationController(rootViewController: loginVC)
        navVC.isNavigationBarHidden = true
        self.window?.rootViewController = navVC
    }
    
    //TODO: Unused
    private func registerUser(uid: String, firebase: String) {
        UserDefaults.standard.set(uid, forKey: "anonymousId")
        let userParam = ["name": "Guest",
                         "uid": uid,
                         "device": "2",
                         "phone": "",
                         "email": "",
                         "firebase": firebase]
        let params = ["st": HConstants.st.registerUser,
                      "user_id": "0",
                      "user": JSON(userParam)] as [String : Any]
//        print("Anonymous ID:- \(uid)")
        UserNetwork().registerUser(params: params) { user in
            if let user1 = user {
                var user2 = user1
                print("User has registered as anonymously...")
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                user2.user.isAnonymous = true
                user2.saveUser()
            }
        }
    }
}
