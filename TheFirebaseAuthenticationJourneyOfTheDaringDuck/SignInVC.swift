//
//  SignInVC.swift
//  TheFirebaseAuthenticationJourneyOfTheDaringDuck
//
//  Created by Cenker Soyak on 18.10.2023.
//

import UIKit
import FirebaseAuth

class SignInVC: UIViewController {
    
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
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.configuration = .filled()
        signInButton.addTarget(self, action: #selector(signInClicked), for: .touchUpInside)
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextfield.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(90)
        }
    }
    func makeAlert(title: String, messageInput: String){
        let alert = UIAlertController(title: title, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    @objc func signInClicked(){
        if emailTextfield.text != "" && passwordTextfield.text != "" {
            Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { result, error in
                if error != nil{
                    print(error!.localizedDescription)
                } else {
                    if Auth.auth().currentUser!.isEmailVerified {
                        let vc = TabBarVC()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    } else {
                        self.makeAlert(title: "Error", messageInput: "You've did not verify your mail.")
                    }
                }
            }
        }
    }
}

