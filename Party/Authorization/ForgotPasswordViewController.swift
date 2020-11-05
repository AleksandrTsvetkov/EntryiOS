//
//  ForgotPasswordViewController.swift
//  Party
//
//  Created by Александр Цветков on 21.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: ViewController {
    
    private let label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        view.text = "Пароль"
        view.textColor = .white
        return view
    }()
    private let buttonView = ButtonView(color: Colors.buttonGray.getValue(), title: "Дальше", left: 16, right: 16)
    private let emailTextFieldView = TextFieldView(text: "", placeholder: "E-mail")
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
    private let checkEmailView = CheckEmailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(label)
        view.addSubview(buttonView)
        view.addSubview(emailTextFieldView)
        view.addSubview(noAccountLabel)
        view.addSubview(registerLabel)
        view.addSubview(checkEmailView)
        
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        emailTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.isUserInteractionEnabled = false
        emailTextFieldView.floatingTextField.delegate = self
        emailTextFieldView.configure(withKeyboardType: .emailAddress, textContentType: .emailAddress)
        emailTextFieldView.floatingTextField.title = "E-MAIL"
        emailTextFieldView.floatingTextField.placeholderFont = UIFont(name: "SFProText-Regular", size: 17)
        emailTextFieldView.floatingTextField.placeholderColor = Colors.gray.getValue()
        emailTextFieldView.floatingTextField.titleColor = Colors.pink.getValue()
        emailTextFieldView.floatingTextField.titleFont = UIFont(name: "SFProText-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
        emailTextFieldView.floatingTextField.errorColor = Colors.red.getValue()
        let tap0 = UITapGestureRecognizer(target: self, action: #selector(registerTapped))
        registerLabel.addGestureRecognizer(tap0)
        emailTextFieldView.floatingTextField.addTarget(self, action: #selector(emailTextFieldChanged), for: .editingChanged)
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(buttonViewTapped))
        buttonView.addGestureRecognizer(tap1)
        checkEmailView.delegate = self
        checkEmailView.isHidden = true
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.heightAnchor.constraint(equalToConstant: 40),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 14),
            
            emailTextFieldView.bottomAnchor.constraint(equalTo: noAccountLabel.topAnchor, constant: -50),
            emailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTextFieldView.heightAnchor.constraint(equalToConstant: 72),
            
            noAccountLabel.topAnchor.constraint(equalTo: registerLabel.topAnchor),
            noAccountLabel.heightAnchor.constraint(equalToConstant: 60),
            noAccountLabel.bottomAnchor.constraint(lessThanOrEqualTo: buttonView.topAnchor, constant: -30),
            noAccountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            noAccountLabel.trailingAnchor.constraint(equalTo: registerLabel.leadingAnchor, constant: -12),
            
            registerLabel.heightAnchor.constraint(equalToConstant: 60),
            registerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            buttonView.heightAnchor.constraint(equalToConstant: 50),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            checkEmailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            checkEmailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            checkEmailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            checkEmailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        if UIScreen.main.bounds.height < 740 {
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
    
    private func checkField() {
        let emailIsReady = emailTextFieldView.floatingTextField.text != "" && emailTextFieldView.floatingTextField.text != nil
        let noErrors = (emailTextFieldView.floatingTextField.errorMessage == "" || emailTextFieldView.floatingTextField.errorMessage == nil)
        if emailIsReady && noErrors {
            buttonView.isUserInteractionEnabled = true
            buttonView.setColor(color: Colors.pink.getValue())
        } else {
            buttonView.isUserInteractionEnabled = false
            buttonView.setColor(color: Colors.buttonGray.getValue())
        }
    }
    
    @objc private func buttonViewTapped() {
        navigationController?.navigationBar.isHidden = true
        checkEmailView.isHidden = false
        NetworkService.shared.forgot(phoneNumber: "") { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
    }
    
    @objc private func emailTextFieldChanged(_ textfield: UITextField) {
        guard
        let textField = textfield as? FloatingField,
        var text = textField.text
        else { return }
        text = text.trimmingCharacters(in: .whitespaces)
        textField.text = text
        let isEmail = text.isEmail()
        textField.errorMessage = (isEmail  || text.isEmpty) ? "" : "Неправильный email".uppercased()
        checkField()
        let noErrors = (textField.errorMessage == "" || textField.errorMessage == nil)
        if !text.isEmpty && noErrors {
            textField.titleColor = Colors.textFieldCorrect.getValue()
        } else {
            textField.titleColor = Colors.gray.getValue()
        }
    }
    
    @objc private func registerTapped() {
        let vc = SignUpViewController()
        let backButton = UIBarButtonItem()
        backButton.title = "Пароль"
        navigationItem.backBarButtonItem = backButton
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

extension ForgotPasswordViewController: ExitDelegate {
    func exitTapped() {
        navigationController?.navigationBar.isHidden = false
        checkEmailView.isHidden = true
    }
}
