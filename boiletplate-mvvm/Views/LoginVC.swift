//
//  LoginVC.swift
//  FATIMA
//
//  Created by EDS on 11/07/2022.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import CountryPickerView
import ProgressHUD
import Firebase
import FirebaseAuth
import LanguageManager_iOS

class LoginVC: UIViewController {
    
    // MARK: - Stored Properties
    var loginViewModel: LoginViewModel!
    weak var loginDelegate: LoginProtocol?
    //MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var usernameTextField: MDCOutlinedTextField!
    
    @IBOutlet weak var mobilenoView: UIView!
    @IBOutlet weak var countryPicker: CountryPickerView!
    @IBOutlet weak var mobilenoTextField: UITextField!
    @IBOutlet weak var getStartButton: UIButton!
    @IBOutlet weak var sloganLabel: UILabel!
    
    //MARK: Private Variables
    private var verificationId = ""
    
    //MARK: - ViewController States
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginViewModel = LoginViewModel(loginManager: UserNetwork())
        self.setupView()
        self.setDelegates()
        self.setupTextFields()
        self.setupButton()
        self.bindData()
    }
    
    //MARK: - IBActions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let zeroFreePhoneNumber = self.mobilenoTextField.text!.replacingOccurrences(of: "^0+",
                                                                                        with: "",
                                                                                        options: .regularExpression)
//        let phoneNumber = countryPicker.selectedCountry.phoneCode + zeroFreePhoneNumber
        //Here we ask viewModel to update model with existing credentials from text fields
        loginViewModel.updateCredentials(username: usernameTextField.text!,
                                         countryCode: countryPicker.selectedCountry.phoneCode,
                                         mobileno: zeroFreePhoneNumber)
        
        //Here we check user's credentials input - if it's correct we call login()
        switch loginViewModel.credentialsInput() {
            
        case .correct:
            login(mobileno: zeroFreePhoneNumber)
        case .incorrect:
            return
        }
    }
    func bindData() {
        loginViewModel.credentialsInputErrorMessage.bind { [weak self] in
            self?.view.snakeBar($0)
        }
        
        loginViewModel.isUsernameTextFieldHighLighted.bind { [weak self] in
            if $0 { self?.usernameTextField.shake() }
        }
        
        loginViewModel.isPasswordTextFieldHighLighted.bind { [weak self] in
            if $0 { self?.mobilenoTextField.shake() }
        }
        
        loginViewModel.errorMessage.bind { [weak self] in
            guard let errorMessage = $0 else { return }
            self?.view.snakeBar(errorMessage)
        }
    }
    private func setupView() {
        self.mobilenoView.border(width: 1, color: .white, cornerRadius: HConstants.Theme.Radius.buttonCornerRadius)
        self.countryPicker.setCountryByCode("AE")
        self.countryPicker.showCountryCodeInView = false
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.setStatusBar(backgroundColor: HConstants.Theme.Colors.AppColor)
    }
    private func setupTextFields() {
        self.customize(textField: self.usernameTextField, placeholder: HLocalized().name)
        self.mobilenoTextField.placeholder = HLocalized().mobileNumber
    }
    private func customize(textField: MDCOutlinedTextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.labelBehavior = .floats
        textField.label.text = placeholder
        textField.label.backgroundColor = .clear
        textField.backgroundColor = .clear
        textField.setOutlineColor(HConstants.Theme.Colors.ColorWhite, for: .normal)
        textField.setOutlineColor(HConstants.Theme.Colors.ColorWhite, for: .editing)
        textField.setOutlineColor(HConstants.Theme.Colors.ColorWhite, for: .disabled)
        textField.placeHolderColor = HConstants.Theme.Colors.lightGrayColor
        textField.keyboardAppearance = .dark
        textField.preferredContainerHeight = 40
        
        if LanguageManager.shared.currentLanguage == .ar {
            textField.textAlignment = .right
        } else {
            textField.textAlignment = .left
        }
    }
    func setupButton() {
        getStartButton.layer.cornerRadius = 22.5
    }
    func setDelegates() {
        usernameTextField.delegate = self
        mobilenoTextField.delegate = self
    }
    func login(mobileno: String) {
        loginViewModel.login { verificationId, error in
            if let id = verificationId {
                self.verificationId = id
                
                UserDefaults.standard.set(mobileno, forKey: "UserPhone")
                UserDefaults.standard.set(self.usernameTextField.text ?? "", forKey: "Username")
                
                let phoneVerificationVC = PhoneVerificationVC.initialize(with: .main)
                phoneVerificationVC.name = self.usernameTextField.text!
                phoneVerificationVC.verificationId = id
                phoneVerificationVC.loginDelegate = self.loginDelegate
//                phoneVerificationVC.isComingFromSettings = self.isComingFromSettings
                self.navigationController?.pushViewController(phoneVerificationVC,
                                                              animated: true)
            }
        }
    }
}
//MARK: - Text Field Delegate Methods
extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        mobilenoTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //        loginErrorDescriptionLabel.isHidden = true
        usernameTextField.layer.borderWidth = 0
        mobilenoTextField.layer.borderWidth = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
