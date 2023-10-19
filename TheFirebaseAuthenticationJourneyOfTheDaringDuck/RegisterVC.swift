//
//  ViewController.swift
//  TheFirebaseAuthenticationJourneyOfTheDaringDuck
//
//  Created by Cenker Soyak on 18.10.2023.
//

import UIKit
import SnapKit
import FirebaseAuth

class RegisterVC: UIViewController {
    
    let instagramCloneLabel = UILabel()
    let emailTextfield = UITextField()
    let passwordTextfield = UITextField()
    let registerButton = UIButton()
    let signInButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    func createUI(){
        view.backgroundColor = .white
        
        instagramCloneLabel.text = "InstagramClone"
        instagramCloneLabel.font = .systemFont(ofSize: 30)
        view.addSubview(instagramCloneLabel)
        instagramCloneLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(220)
        }
        emailTextfield.placeholder = "Enter your e-mail: "
        emailTextfield.textColor = .black
        emailTextfield.layer.borderColor = UIColor(.black).cgColor
        emailTextfield.textAlignment = .center
        emailTextfield.borderStyle = .roundedRect
        emailTextfield.layer.cornerRadius = 5
        view.addSubview(emailTextfield)
        emailTextfield.snp.makeConstraints { make in
            make.top.equalTo(instagramCloneLabel.snp.bottom).offset(90)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
        passwordTextfield.placeholder = "Enter your password: "
        passwordTextfield.textAlignment = .center
        passwordTextfield.layer.borderColor = UIColor(.black).cgColor
        passwordTextfield.borderStyle = .roundedRect
        passwordTextfield.layer.cornerRadius = 5
        passwordTextfield.isSecureTextEntry = true
        view.addSubview(passwordTextfield)
        passwordTextfield.snp.makeConstraints { make in
            make.top.equalTo(emailTextfield.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
        registerButton.setTitle("Register", for: .normal)
        registerButton.configuration = .filled()
        view.addSubview(registerButton)
        registerButton.addTarget(self, action: #selector(registerClicked), for: .touchUpInside)
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextfield.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(90)
        }
        signInButton.setTitle("Have you registered before?", for: .normal)
        signInButton.configuration = .borderedTinted()
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(signInClicked), for: .touchUpInside)
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    @objc func registerClicked(){
        if emailTextfield.text != "" && passwordTextfield.text != "" {
            Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { result, error in
                if error == nil {
                    Auth.auth().currentUser?.sendEmailVerification()
                    self.verificationAlert(titleInput: "Done", messageInput: "Verification mail has been sent")
                } else {
                    print(error!.localizedDescription)
                }
            }
        } else {
            verificationAlert(titleInput: "Error", messageInput: "Username or Password is nil")
        }
    }
    @objc func signInClicked(){
        let signinVC = SignInVC()
        signinVC.modalPresentationStyle = .fullScreen
        present(signinVC, animated: true)
    }
    func verificationAlert(titleInput: String, messageInput: String){
        let verificationAlert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        verificationAlert.addAction(okButton)
        self.present(verificationAlert, animated: true)
    }
}
