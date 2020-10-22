//
//  CheckEmailView.swift
//  Party
//
//  Created by Александр Цветков on 21.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class CheckEmailView: UIView {
    
    var delegate: ExitDelegate?
    
    private let emailImageView: UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: "emailPicture")
        view.image = image
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "Проверьте почту"
        view.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let subtitleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 0
        view.text = "Мы отправили Вам ссылку для восстановления пароля"
        view.font = UIFont(name: "SFProText-Regular", size: 17)
        view.textColor = Colors.gray.getValue()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let exitButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(UIImage(named: "exitEmail"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: .zero)
        setupViews()
    }
    
    private func setupViews() {
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black
        addSubview(emailImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(exitButton)
        
        NSLayoutConstraint.activate([
            emailImageView.heightAnchor.constraint(equalToConstant: 275),
            emailImageView.widthAnchor.constraint(equalToConstant: 275),
            emailImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: emailImageView.bottomAnchor, constant: 50),
            titleLabel.heightAnchor.constraint(equalToConstant: 42),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 48),
            subtitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -200),
            
            exitButton.heightAnchor.constraint(equalToConstant: 50),
            exitButton.widthAnchor.constraint(equalToConstant: 50),
            exitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            exitButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50)
        ])
        
        if UIScreen.main.bounds.width < 600 {
            NSLayoutConstraint.activate([
                emailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            ])
        } else {
            NSLayoutConstraint.activate([
                emailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
            ])
        }
    }
    
    @objc private func exitButtonTapped() {
        delegate?.exitTapped()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

protocol ExitDelegate {
    func exitTapped()
}
