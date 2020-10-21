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
        view.text = "ЗАБЫЛИ ПАРОЛЬ?"
        view.font = UIFont(name: "SFProText-Regular", size: 12)
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
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
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.heightAnchor.constraint(equalToConstant: 40),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 14),
            
            emailTextFieldView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 140),
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
            noAccountLabel.heightAnchor.constraint(equalToConstant: 22),
            noAccountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noAccountLabel.trailingAnchor.constraint(equalTo: registerLabel.leadingAnchor, constant: -12),
            
            registerLabel.heightAnchor.constraint(equalTo: noAccountLabel.heightAnchor),
            registerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
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
            ])
        } else {
            NSLayoutConstraint.activate([
                buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            ])
        }
    }
    
    override func willMove(toParent parent: UIViewController?) {
        if parent == nil {
            guard let navigationVC = navigationController else { return }
            if navigationVC.viewControllers.count > 2 {
                navigationVC.removeControllers(in: 1...2)
            }
            delegate?.blurEffectView.isHidden = true
            delegate?.authView.isHidden = true
            delegate?.authView.transform = .identity
            delegate?.authViewIsVisibleConstraint.isActive = false
            delegate?.authViewIsHiddenConstraint.isActive = true
            navigationController?.navigationBar.isHidden = true
        }
    }
}
