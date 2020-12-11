//
//  AuthTypeView.swift
//  Party
//
//  Created by Александр Цветков on 16.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class AuthTypeView: UIView {
    
    //MARK: - Subviews
    private let label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.font = UIFont(name: "SFProDisplay-Medium", size: 18)
        view.textColor = .white
        return view
    }()
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "FFFFFF", alpha: 0.1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(type: AuthType) {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        setupSubviews()
        
        switch type {
        case .signUp:
            imageView.image = UIImage(named: "signUpIcon")
            label.text = "Зарегистрироваться"
        case .signIn:
            imageView.image = UIImage(named: "signInIcon")
            label.text = "Войти"
        case .google:
            imageView.image = UIImage(named: "googleIcon")
            label.text = "Continue with Google"
        case .fb:
            imageView.image = UIImage(named: "fbIcon")
            label.text = "Continue with Facebook"
        case .apple:
            imageView.image = UIImage(named: "appleIcon")
            label.text = "Continue with Apple"
            lineView.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    private func setupSubviews() {
        addSubview(label)
        addSubview(imageView)
        addSubview(lineView)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 54),
            
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            
            label.heightAnchor.constraint(equalToConstant: 21),
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 14),
            label.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: 20)
        ])
    }
}

enum AuthType: CaseIterable {
    case signUp
    case signIn
    case google
    case fb
    case apple
}
