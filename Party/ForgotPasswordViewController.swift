//
//  ForgotPasswordViewController.swift
//  Party
//
//  Created by Александр Цветков on 21.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
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
        view.textAlignment = .center
        view.text = "Еще нет аккаунта?"
        view.font = UIFont(name: "SFProText-Semibold", size: 16)
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let registerLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.isUserInteractionEnabled = true
        view.text = "Зарегистрироваться"
        view.font = UIFont(name: "SFProText-Regular", size: 16)
        view.textColor = UIColor(hex: "FFFFFF", alpha: 0.65)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(registerTapped))
        registerLabel.addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.heightAnchor.constraint(equalToConstant: 40),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 14),
            
            emailTextFieldView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 140),
            emailTextFieldView.bottomAnchor.constraint(equalTo: noAccountLabel.topAnchor, constant: -50),
            emailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTextFieldView.heightAnchor.constraint(equalToConstant: 72),
            
            noAccountLabel.topAnchor.constraint(equalTo: registerLabel.topAnchor),
            noAccountLabel.heightAnchor.constraint(equalToConstant: 22),
            noAccountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            noAccountLabel.trailingAnchor.constraint(equalTo: registerLabel.leadingAnchor, constant: -12),
            
            registerLabel.heightAnchor.constraint(equalTo: noAccountLabel.heightAnchor),
            registerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            buttonView.heightAnchor.constraint(equalToConstant: 50),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        if UIScreen.main.bounds.height < 600 {
            NSLayoutConstraint.activate([
                buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            ])
        } else {
            NSLayoutConstraint.activate([
                buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            ])
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
