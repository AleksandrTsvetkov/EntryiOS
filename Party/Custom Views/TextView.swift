//
//  TextView.swift
//  Party
//
//  Created by Александр Цветков on 05.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class TextView: UIView {
    
    var delegate: TextViewDelegate?
    var textViewType: ProfileFieldType = .personalData
    private let label: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.font = UIFont(name: "SFProText-Regular", size: 17)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.separator.getValue()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    convenience init(ofType type: ProfileFieldType) {
        self.init(frame: .zero)
        backgroundColor = Colors.backgroundGray.getValue()
        textViewType = type
        let tap = UITapGestureRecognizer(target: self, action: #selector(textViewTapped))
        addGestureRecognizer(tap)
        switch type {
        case .personalData:
            label.text = "Персональные данные"
            configureRoundSide(.top)
        case .paymentData:
            label.text = "Платежные данные"
            configureRoundSide(.none)
        case .contacts:
            label.text = "Контакты"
            configureRoundSide(.none)
        case .changePassword:
            label.text = "Изменить пароль"
            configureRoundSide(.bottom)
        case .exit:
            label.text = "Выйти"
            configureRoundSide(.both)
        case .phoneRegister:
            label.text = "Зарегистрироваться по номеру"
            configureRoundSide(.top)
        case .loginPhone:
            label.text = "Войти по номеру"
            configureRoundSide(.none)
        case .loginApple:
            label.text = "Продолжить с Apple"
            configureRoundSide(.none)
        case .loginVK:
            label.text = "Войти через VK"
            configureRoundSide(.none)
        case .loginFacebook:
            label.text = "Войти через Facebook"
            configureRoundSide(.none)
        case .loginGoogle:
            label.text = "Войти через Google"
            configureRoundSide(.bottom)
        }
        setupViews()
    }
    
    private func setupViews() {
        addSubview(label)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 51),
            
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: 22),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -15),
        ])
    }
    
    private func configureRoundSide(_ roundSide: RoundSide) {
        switch roundSide {
        case .top:
            self.layer.cornerRadius = 12
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            addSeparator()
        case .bottom:
            self.layer.cornerRadius = 12
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .both:
            self.layer.cornerRadius = 12
        case .none:
            addSeparator()
        }
    }
    
    private func addSeparator() {
        addSubview(separator)
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            separator.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    @objc private func textViewTapped() {
        delegate?.tapOnTextView(ofType: textViewType)
    }
    
    enum RoundSide {
        case top
        case bottom
        case both
        case none
    }
}

enum ProfileFieldType {
    case personalData
    case paymentData
    case contacts
    case changePassword
    case exit
    case phoneRegister
    case loginPhone
    case loginApple
    case loginVK
    case loginFacebook
    case loginGoogle
}

protocol TextViewDelegate {
    func tapOnTextView(ofType type: ProfileFieldType)
}
