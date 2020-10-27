//
//  NewPasswordViewController.swift
//  Party
//
//  Created by Александр Цветков on 21.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class NewPasswordViewController: UIViewController {
    
    private let label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        view.text = "Новый пароль"
        view.textColor = .white
        return view
    }()
    private let passwordTextFieldView = TextFieldView(text: "", placeholder: "Пароль")
    private let confirmPasswordTextFieldView = TextFieldView(text: "", placeholder: "Пароль еще раз")
    private let buttonView = ButtonView(color: Colors.buttonGray.getValue(), title: "Дальше", left: 16, right: 16)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
        configureTextFields()
    }
    
    private func setupViews() {
        view.addSubview(label)
        view.addSubview(passwordTextFieldView)
        view.addSubview(confirmPasswordTextFieldView)
        view.addSubview(buttonView)
        
        passwordTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        passwordTextFieldView.floatingTextField.delegate = self
        confirmPasswordTextFieldView.floatingTextField.delegate = self
        let tap0 = UITapGestureRecognizer(target: self, action: #selector(buttonViewTapped))
        buttonView.addGestureRecognizer(tap0)
        buttonView.isUserInteractionEnabled = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.heightAnchor.constraint(equalToConstant: 40),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            
            passwordTextFieldView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 65),
            passwordTextFieldView.bottomAnchor.constraint(equalTo: confirmPasswordTextFieldView.topAnchor, constant: -16),
            passwordTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordTextFieldView.heightAnchor.constraint(equalToConstant: 72),
            
            confirmPasswordTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            confirmPasswordTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            confirmPasswordTextFieldView.heightAnchor.constraint(equalToConstant: 72),
            
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
    
    private func configureTextFields() {
        passwordTextFieldView.floatingTextField.title = "ПАРОЛЬ"
        passwordTextFieldView.floatingTextField.placeholderFont = UIFont(name: "SFProText-Regular", size: 17)
        passwordTextFieldView.floatingTextField.placeholderColor = Colors.gray.getValue()
        passwordTextFieldView.floatingTextField.titleColor = Colors.pink.getValue()
        passwordTextFieldView.floatingTextField.titleFont = UIFont(name: "SFProText-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
        passwordTextFieldView.floatingTextField.errorColor = Colors.red.getValue()
        passwordTextFieldView.floatingTextField.isSecureTextEntry = true
        passwordTextFieldView.floatingTextField.addTarget(self, action: #selector(passwordTextFieldChanged), for: .editingChanged)
        
        confirmPasswordTextFieldView.floatingTextField.title = "ПАРОЛЬ ЕЩЕ РАЗ"
        confirmPasswordTextFieldView.floatingTextField.placeholderFont = UIFont(name: "SFProText-Regular", size: 17)
        confirmPasswordTextFieldView.floatingTextField.placeholderColor = Colors.gray.getValue()
        confirmPasswordTextFieldView.floatingTextField.titleColor = Colors.pink.getValue()
        confirmPasswordTextFieldView.floatingTextField.titleFont = UIFont(name: "SFProText-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
        confirmPasswordTextFieldView.floatingTextField.errorColor = Colors.red.getValue()
        confirmPasswordTextFieldView.floatingTextField.isSecureTextEntry = true
        confirmPasswordTextFieldView.floatingTextField.addTarget(self, action: #selector(confirmPasswordTextFieldChanged), for: .editingChanged)
    }
    
    private func checkFields() {
        let isEqual = passwordTextFieldView.floatingTextField.text == confirmPasswordTextFieldView.floatingTextField.text
        let passwordNotEmpty = passwordTextFieldView.floatingTextField.text != "" && passwordTextFieldView.floatingTextField.text != nil
        let confirmPasswordNotEmpty = confirmPasswordTextFieldView.floatingTextField.text != "" && confirmPasswordTextFieldView.floatingTextField.text != nil
        if isEqual && passwordNotEmpty && confirmPasswordNotEmpty {
            buttonView.isUserInteractionEnabled = true
            passwordTextFieldView.floatingTextField.titleColor = Colors.textFieldCorrect.getValue()
            confirmPasswordTextFieldView.floatingTextField.titleColor = Colors.textFieldCorrect.getValue()
            buttonView.setColor(color: Colors.pink.getValue())
        } else {
            buttonView.isUserInteractionEnabled = false
            passwordTextFieldView.floatingTextField.titleColor = Colors.pink.getValue()
            confirmPasswordTextFieldView.floatingTextField.titleColor = Colors.pink.getValue()
            buttonView.setColor(color: Colors.buttonGray.getValue())
        }
    }
    
    @objc private func passwordTextFieldChanged() {
        checkFields()
    }
    
    @objc private func confirmPasswordTextFieldChanged() {
        checkFields()
    }
    
    @objc private func buttonViewTapped() {
        
    }

}

extension NewPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
