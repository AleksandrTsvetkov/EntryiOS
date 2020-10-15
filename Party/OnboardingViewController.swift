//
//  OnboardingViewController.swift
//  Party
//
//  Created by Александр Цветков on 15.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private let whyImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "why")
        return view
    }()
    private let exitButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(named: "exit"), for: .normal)
        return view
    }()
    private let buttonView = ButtonView(color: Colors.pink.getValue(), title: "Дальше", left: 32, right: 32)
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        for _ in 0...2 {
            let view = FeatureView(title: "Onboarding feature #1", subtitle: "This is the feature number 1 of this great app", image: UIImage(named: "imagePlaceholder"))
            stackView.addArrangedSubview(view)
        }
        stackView.axis = .vertical
        stackView.spacing = 39
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(buttonViewTapped))
        buttonView.addGestureRecognizer(tap)
    }

    private func setupViews() {
        view.addSubview(stackView)
        view.addSubview(whyImageView)
        view.addSubview(exitButton)
        view.addSubview(buttonView)
        
        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            exitButton.heightAnchor.constraint(equalToConstant: 30),
            exitButton.widthAnchor.constraint(equalToConstant: 30),
            
            whyImageView.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 41),
            whyImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            whyImageView.heightAnchor.constraint(equalToConstant: 36),
            whyImageView.widthAnchor.constraint(equalToConstant: 186),
            
            stackView.topAnchor.constraint(equalTo: whyImageView.bottomAnchor, constant: 72),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: buttonView.topAnchor, constant: -100),
            
            buttonView.heightAnchor.constraint(equalToConstant: 50),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
    
    @objc private func buttonViewTapped() {
        
    }
}

