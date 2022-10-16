//
//  LoginViewController.swift
//  UIKitIntroductionApp DesignCode IOS15
//
//  Created by Sergey Kovalev on 3/31/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    enum LoginStatus {
        case signUp
        case signIn
    }
    
    @IBOutlet var loginView: CustomView!
    @IBOutlet var signUpLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var createAccountButton: UIButton!
    @IBOutlet var signInButton: UIButton!
    
    var loginStatus: LoginStatus = .signUp {
        didSet {
            signUpLabel.text = (loginStatus == .signUp) ? "Sign Up" : "Sign In"
            let buttonTitle = (loginStatus == .signUp) ? "Create Account" : "Sign In"
            createAccountButton.setTitle(buttonTitle, for: .normal)
            
            let infoTextPart = (loginStatus == .signUp) ? "Create Account" : "Log In"
            let infoText = "By clicking on \(infoTextPart), you agree to our Terms of service and Privacy policy."
            infoLabel.text = infoText
            
            let secondButtonTitle = (loginStatus == .signUp) ? "Don't have an account?" : "Already have an account?"
            signInButton.setTitle(secondButtonTitle, for: .normal)
            
            passwordTextField.textContentType =  (loginStatus == .signUp) ? .newPassword : .password
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
 
    override func viewDidLoad() {
        
        cardViewAnimation()
        
        // TODO: create button that allows user see entered password
//        passwordTextField.isSecureTextEntry
        
        
    }
    
    private func cardViewAnimation() {
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseInOut) {
            self.loginView.alpha = 1
            self.loginView.frame = self.loginView.frame.offsetBy(dx: 0, dy: -400)
        }
    }
        // alert controller func
    private func alertMessage(title: String, message: String, alertActionMessage: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: alertActionMessage, style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func goToHomeScreen() {
        let vcID = "CustomTabBarViewController"
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: vcID) as! CustomTabBarViewController
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: IBActions
    @IBAction func onCreateAccountButtonTapped(_ sender: Any) {
        
        // TODO: make email and password verification format with alerts
        // Unwrap optional
        guard let email = emailTextField.text?.lowercased(), let password = passwordTextField.text else { return }
        
        
        if !email.isValidEmail() { // Check if email format is correct
            alertMessage(title: "Email format is wrong", message: "Check your information please", alertActionMessage: "OK")
        } else if !password.isValidPassword() { // Check if password format is correct
            alertMessage(title: "Password format is wrong", message: "Password should be minimum 8 characters length, have at least 1 Uppercase Alphabet, 1 Lowercase Alphabet and 1 Number", alertActionMessage: "OK")
        } else { // Creating new user using a form
            if loginStatus == .signUp {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil else {
                        let errorMessage = error?.localizedDescription ?? "Try again"
                        self.alertMessage(title: "Failed to create an account", message: errorMessage, alertActionMessage: "OK")
                        print("you got an error: \(error?.localizedDescription ?? "")")
                        return
                    }
                    self.goToHomeScreen()
                }
            } else { // loginin in with existing user with email and password
                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    guard error == nil else {
                        self.alertMessage(title: "Failed to log in", message: "User with such Email or Password doesn't exist", alertActionMessage: "OK")
                        print("Failed to log in with an error: \(error?.localizedDescription ?? "")")
                        return
                    }
                    self.goToHomeScreen()
                }
            }
        }
    }
    
    @IBAction func onSignInButtonTapped(_ sender: Any) {
        loginStatus = (loginStatus == .signUp) ? .signIn : .signUp
    }
    
}
