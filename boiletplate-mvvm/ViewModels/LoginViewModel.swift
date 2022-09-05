//
//  LoginViewModel.swift
//  FATIMA
//
//  Created by EDS on 11/07/2022.
//

import Foundation
import UIKit
struct DummyError: Error {
    var title: String
}

class LoginViewModel {
    // MARK: - Stored Properties
    private let loginManager: UserNetwork
    
    //Here our model notify that was updated
    private var credentials = Credentials() {
        didSet {
            username = credentials.username
            countryCode = credentials.countryCode
            mobileno = credentials.mobileno
        }
    }
    
    private var username = ""
    private var countryCode = ""
    private var mobileno = ""
    
    var credentialsInputErrorMessage: Observable<String> = Observable("")
    var isUsernameTextFieldHighLighted: Observable<Bool> = Observable(false)
    var isPasswordTextFieldHighLighted: Observable<Bool> = Observable(false)
    var errorMessage: Observable<String?> = Observable(nil)
    
    init(loginManager: UserNetwork) {
        self.loginManager = loginManager
    }
    
    //Here we update our model
    func updateCredentials(username: String,
                           countryCode: String,
                           mobileno: String,
                           otp: String? = nil) {
        credentials.username = username
        credentials.countryCode = countryCode
        credentials.mobileno = mobileno
    }
    
    func login(_ completionHandler: @escaping ((_ verificationId: String?,
                                                _ error: Error?) -> Void)) {
        completionHandler("verificationId", DummyError(title: "Error"))
//        return
        //TODO: Uncomment below these lines
//        WALoader.showAnimated()
//        let mobile = countryCode + mobileno
//        loginManager.loginWithCredentials(username: username, mobileno: mobile) { [weak self] (verificationId, error) in
//            WALoader.dismiss()
//            guard let error = error else {
//                return
//            }
//
//            self?.errorMessage.value = error.localizedDescription
//            completionHandler(verificationId, error)
//        }
    }
    
    func credentialsInput() -> CredentialsInputStatus {
        //TODO: Uncomment these lines
//        if username.isEmpty && mobileno.isEmpty {
//            credentialsInputErrorMessage.value = "Please provide username and mobile no."
//            return .incorrect
//        }
//        if username.isEmpty {
//            credentialsInputErrorMessage.value = "Username field is empty."
//            isUsernameTextFieldHighLighted.value = true
//            return .incorrect
//        }
//        if mobileno.isEmpty {
//            credentialsInputErrorMessage.value = "Mobile No field is empty."
//            isPasswordTextFieldHighLighted.value = true
//            return .incorrect
//        }
        return .correct
    }
}

extension LoginViewModel {
    enum CredentialsInputStatus {
        case correct
        case incorrect
    }
}
