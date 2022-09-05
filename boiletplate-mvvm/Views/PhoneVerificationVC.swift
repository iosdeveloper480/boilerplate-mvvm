//
//  PhoneVerificationVC.swift
//  Asmaky
//
//  Created by mac on 14/11/2021.
//

import UIKit
import SVPinView
import ProgressHUD
import Firebase
import FirebaseAuth
import SwiftyJSON
import LanguageManager_iOS

class PhoneVerificationVC: UIViewController {

    @IBOutlet weak var fieldsView: UIView!
    @IBOutlet weak var pinView: SVPinView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var verifyButton: UIButton!
    
    weak var loginDelegate: LoginProtocol?
    var name = ""
    var verificationId = ""
    var isComingFromSettings = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = HLocalized().phoneVerification
        self.descriptionLabel.text = HLocalized().opt
        self.verifyButton.setTitle(HLocalized().verifyNow, for: .normal)
        self.verifyButton.cornerRadius(cornerRadius: 22.5)
        self.verifyButton.setTitleColor(.black, for: .normal)
        
        self.fieldsView.backgroundColor = .clear
        
        if LanguageManager.shared.currentLanguage == .ar {
            self.pinView.semanticContentAttribute = .forceRightToLeft
        }
        pinView.backgroundColor = .clear
        pinView.style = .box
        pinView.fieldCornerRadius = 10
        pinView.activeFieldCornerRadius = 10
        pinView.borderLineColor = HConstants.Theme.Colors.AppColor
        pinView.activeBorderLineColor = HConstants.Theme.Colors.AppColor
        pinView.activeBorderLineThickness = 2
        pinView.borderLineThickness = 1
        pinView.didFinishCallback = { [weak self] pin in
            self?.signIn()
//            print("The pin entered is \(pin)")
        }
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.setStatusBar(backgroundColor: HConstants.Theme.Colors.AppColor)
        self.navigationController?.navigationBar.tintColor = .white
//        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.setNavigationBarColor(color: .white)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}
extension PhoneVerificationVC: FederatedAuthProvider {
    func getCredentialWith(_ UIDelegate: AuthUIDelegate?, completion: ((AuthCredential?, Error?) -> Void)? = nil) {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.verificationId,
                                                                 verificationCode: self.pinView.getPin())
        completion!(credential, nil)
    }
}
extension PhoneVerificationVC {
    @IBAction func signIn() {
        self.loginDelegate?.loginSuccessfully()
        return
//        DispatchQueue.main.async {
//            WALoader.showAnimated()
//            
//            Auth.auth().signIn(with: self, uiDelegate: nil, completion: { authResult, error in
//                WALoader.dismiss()
//                if let error = error {
//                    print(error.localizedDescription)
//                    return
//                }
//                if let result = authResult  {
////                    self.loginDelegate?.loginSuccessfully()
//                    var user = UserModel.getUser()
//                    user?.user.isAnonymous = false
////                    user?.user.uid = result.user.uid
//                    user?.user.phone = UserDefaults.standard.object(forKey: "UserPhone") as! String
//                    user?.user.name = UserDefaults.standard.object(forKey: "Username") as! String
//                    
//                    result.user.getIDToken() { (idToken, error) in
//                        if error == nil, let token = idToken {
//                            print(token)
//                            user?.user.firebase = token
//                            self.registerUser(uid: result.user.uid)
////                            user?.saveUser()
//                        } else {
//                            //error handling
//                        }
//                    }
//                }
//                // User signed in
//            })
//            
////            Auth.auth().currentUser?.link(with: credential, completion: { authResult, error in
////            })
////            Auth.auth().signIn(with: credential) { (authResult, error) in
////            }
//        }
    }
    
    private func registerUser(uid: String) {
        let userParam = ["name": Helper.getUserName(),
                         "uid": uid,//new user id
                         "device": "2",
                         "phone": Helper.getUserPhone(),
                         "email": "0",
                         "firebase": Helper.getFCMToken()]
        let params = ["st": HConstants.st.registerUser,
                      "user_id": UserModel.getUser()?.user.uid ?? "", //anonymous user id
                      "user": JSON(userParam)] as [String : Any]
        WALoader.showAnimated()
//        print("Permanent ID:- \(uid)")
        UserNetwork().registerUser(params: params) { user in
            WALoader.dismiss()
            if let user = user {
//                print("User has registered as permanently...")
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                user.saveUser()
                if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    if self.isComingFromSettings {
//                        LocationModel.removeLocation()
                    }
                    delegate.isLogin()
                }
            }
        }
    }
}
