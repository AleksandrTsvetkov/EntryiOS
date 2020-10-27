//
//  LoginViewController.swift
//  Party
//
//  Created by Александр Цветков on 21.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var delegate: OnboardingViewController?
    private let label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        view.text = "Вход"
        view.textColor = .white
        return view
    }()
    private let emailTextFieldView = TextFieldView(text: "", placeholder: "E-mail")
    private let passwordTextFieldView = TextFieldView(text: "", placeholder: "Пароль")
    private let forgotPasswordLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .right
        view.isUserInteractionEnabled = true
        view.text = "ЗАБЫЛИ ПАРОЛЬ?"
        view.font = UIFont(name: "SFProText-Regular", size: 12)
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let noAccountLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.text = "Еще нет аккаунта?"
        view.font = UIFont(name: "SFProText-Semibold", size: 16)
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let registerLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .right
        view.isUserInteractionEnabled = true
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.text = "Зарегистрироваться"
        view.font = UIFont(name: "SFProText-Regular", size: 16)
        view.textColor = UIColor(hex: "FFFFFF", alpha: 0.65)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let errorLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.text = "Произошла ошибка!\nПопробуйте ещё раз"
        view.numberOfLines = 0
        view.isHidden = true
        view.font = UIFont(name: "SFProText-Regular", size: 17)
        view.textColor = Colors.red.getValue()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let buttonView = ButtonView(color: Colors.buttonGray.getValue(), title: "Дальше", left: 16, right: 16)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupViews()
        configureTextFields()
        setupActions()
    }
    
    private func setupActions() {
        let tap0 = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordTapped))
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(registerTapped))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(buttonViewTapped))
        forgotPasswordLabel.addGestureRecognizer(tap0)
        registerLabel.addGestureRecognizer(tap1)
        buttonView.addGestureRecognizer(tap2)
        emailTextFieldView.floatingTextField.delegate = self
        passwordTextFieldView.floatingTextField.delegate = self
        emailTextFieldView.floatingTextField.addTarget(self, action: #selector(emailTextFieldChanged), for: .editingChanged)
        passwordTextFieldView.floatingTextField.addTarget(self, action: #selector(passwordTextFieldChanged), for: .editingChanged)
    }
    
    private func setupViews() {
        view.addSubview(label)
        view.addSubview(emailTextFieldView)
        view.addSubview(passwordTextFieldView)
        view.addSubview(forgotPasswordLabel)
        view.addSubview(noAccountLabel)
        view.addSubview(registerLabel)
        view.addSubview(errorLabel)
        view.addSubview(buttonView)
        
        buttonView.isUserInteractionEnabled = false
        buttonView.setColor(color: Colors.buttonGray.getValue())
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.heightAnchor.constraint(equalToConstant: 40),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 14),
            
            emailTextFieldView.bottomAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: -16),
            emailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTextFieldView.heightAnchor.constraint(equalToConstant: 72),
            
            passwordTextFieldView.bottomAnchor.constraint(equalTo: forgotPasswordLabel.topAnchor, constant: -17),
            passwordTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordTextFieldView.heightAnchor.constraint(equalToConstant: 72),
            
            forgotPasswordLabel.heightAnchor.constraint(equalToConstant: 16),
            forgotPasswordLabel.bottomAnchor.constraint(equalTo: registerLabel.topAnchor, constant: -48),
            forgotPasswordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            noAccountLabel.topAnchor.constraint(equalTo: registerLabel.topAnchor),
            noAccountLabel.heightAnchor.constraint(equalToConstant: 60),
            noAccountLabel.bottomAnchor.constraint(lessThanOrEqualTo: buttonView.topAnchor, constant: -30),
            noAccountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            noAccountLabel.trailingAnchor.constraint(equalTo: registerLabel.leadingAnchor, constant: -12),
            
            registerLabel.heightAnchor.constraint(equalToConstant: 60),
            registerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            errorLabel.topAnchor.constraint(equalTo: noAccountLabel.bottomAnchor, constant: 60),
            errorLabel.heightAnchor.constraint(equalToConstant: 45),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            buttonView.heightAnchor.constraint(equalToConstant: 50),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        if UIScreen.main.bounds.height < 600 {
            NSLayoutConstraint.activate([
                buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
                emailTextFieldView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            ])
        } else {
            NSLayoutConstraint.activate([
                buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
                emailTextFieldView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 140),
            ])
        }
    }
    
    private func configureTextFields() {
        emailTextFieldView.configure(withKeyboardType: .emailAddress, textContentType: .emailAddress)
        passwordTextFieldView.floatingTextField.isSecureTextEntry = true
        emailTextFieldView.floatingTextField.title = "E-MAIL"
        emailTextFieldView.floatingTextField.placeholderFont = UIFont(name: "SFProText-Regular", size: 17)
        emailTextFieldView.floatingTextField.placeholderColor = Colors.gray.getValue()
        emailTextFieldView.floatingTextField.titleColor = Colors.pink.getValue()
        emailTextFieldView.floatingTextField.titleFont = UIFont(name: "SFProText-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
        emailTextFieldView.floatingTextField.errorColor = Colors.red.getValue()
        passwordTextFieldView.floatingTextField.title = "ПАРОЛЬ"
        passwordTextFieldView.floatingTextField.placeholderFont = UIFont(name: "SFProText-Regular", size: 17)
        passwordTextFieldView.floatingTextField.placeholderColor = Colors.gray.getValue()
        passwordTextFieldView.floatingTextField.titleColor = Colors.pink.getValue()
        passwordTextFieldView.floatingTextField.titleFont = UIFont(name: "SFProText-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
        passwordTextFieldView.floatingTextField.errorColor = Colors.red.getValue()
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if parent == nil {
            guard let navigationVC = navigationController else { return }
            if navigationVC.viewControllers.count > 2 {
                let count = navigationVC.viewControllers.count
                navigationVC.removeControllers(in: 1...count - 2)
            }
            delegate?.blurEffectView.isHidden = true
            delegate?.authView.isHidden = true
            delegate?.authView.transform = .identity
            delegate?.authViewIsVisibleConstraint.isActive = false
            delegate?.authViewIsHiddenConstraint.isActive = true
            navigationController?.navigationBar.isHidden = true
        }
    }
    
    private func checkFields() {
        let emailIsReady = emailTextFieldView.floatingTextField.text != "" && emailTextFieldView.floatingTextField.text != nil
        let passwordIsReady = passwordTextFieldView.floatingTextField.text != "" && passwordTextFieldView.floatingTextField.text != nil
        if emailIsReady && passwordIsReady {
            buttonView.isUserInteractionEnabled = true
            buttonView.setColor(color: Colors.pink.getValue())
        } else {
            buttonView.isUserInteractionEnabled = false
            buttonView.setColor(color: Colors.buttonGray.getValue())
        }
    }
    
    private func verify() {
        NetworkService.shared.verify { result in
            switch result {
            case .success(let data):
                do {
                    guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                    print("-----Verify-----")
                    print(dict)
                    print("-----Verify-----")
                    if let valid = dict["valid"] as? Int {
                        if valid == 1 {
                            //TODO: - Make alert
                            print("Auth is valid")
                        }
                    }
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - Objc methods
    @objc private func forgotPasswordTapped() {
        let vc = ForgotPasswordViewController()
        let backButton = UIBarButtonItem()
        backButton.title = "Вход"
        navigationItem.backBarButtonItem = backButton
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func registerTapped() {
        let vc = SignUpViewController()
        let backButton = UIBarButtonItem()
        backButton.title = "Вход"
        navigationItem.backBarButtonItem = backButton
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func buttonViewTapped() {
        guard
            let email = emailTextFieldView.floatingTextField.text,
            let password = passwordTextFieldView.floatingTextField.text
            else { return}
        NetworkService.shared.login(phoneNumber: email, password: password) { result in
            switch result {
            case .success(let data):
                do {
                    guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                    print("-----Login-----")
                    print(dict)
                    print("-----Login-----")
                    let defaults = UserDefaults.standard
                    if let accessToken = dict["access_token"] as? String {
                        defaults.set(accessToken, forKey: "access_token")
                    }
                    if let refreshToken = dict["refresh_token"] as? String {
                        defaults.set(refreshToken, forKey: "refresh_token")
                    }
                    
                } catch {
                    self.errorLabel.isHidden = false
                    self.emailTextFieldView.floatingTextField.errorMessage = "E-MAIL"
                    self.passwordTextFieldView.floatingTextField.errorMessage = "ПАРОЛЬ"
                    print(error)
                }
                self.verify()
            case .failure(let error):
                self.errorLabel.isHidden = false
                self.emailTextFieldView.floatingTextField.errorMessage = "E-MAIL"
                self.passwordTextFieldView.floatingTextField.errorMessage = "ПАРОЛЬ"
                print(error)
            }
        }
    }
    
    @objc private func emailTextFieldChanged() {
        emailTextFieldView.floatingTextField.text = emailTextFieldView.floatingTextField.text?.trimmingCharacters(in: .whitespaces)
        emailTextFieldView.floatingTextField.errorMessage = ""
        passwordTextFieldView.floatingTextField.errorMessage = ""
        errorLabel.isHidden = true
        checkFields()
    }
    
    @objc private func passwordTextFieldChanged() {
        passwordTextFieldView.floatingTextField.text = passwordTextFieldView.floatingTextField.text?.trimmingCharacters(in: .whitespaces)
        emailTextFieldView.floatingTextField.errorMessage = ""
        passwordTextFieldView.floatingTextField.errorMessage = ""
        errorLabel.isHidden = true
        checkFields()
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
