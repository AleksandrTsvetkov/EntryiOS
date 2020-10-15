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
    private let authView = AuthView()
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
        
        let tap0 = UITapGestureRecognizer(target: self, action: #selector(buttonViewTapped))
        buttonView.addGestureRecognizer(tap0)
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(exitButtonTapped))
        exitButton.addGestureRecognizer(tap1)
        authView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }

    private func setupViews() {
        view.addSubview(stackView)
        view.addSubview(whyImageView)
        view.addSubview(exitButton)
        view.addSubview(buttonView)
        view.addSubview(blurEffectView)
        view.addSubview(authView)
        authView.isHidden = true
        
        
        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            exitButton.heightAnchor.constraint(equalToConstant: 30),
            exitButton.widthAnchor.constraint(equalToConstant: 30),
            
            whyImageView.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 41),
            whyImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            whyImageView.heightAnchor.constraint(equalToConstant: 36),
            whyImageView.widthAnchor.constraint(equalToConstant: 186),
            
            stackView.topAnchor.constraint(equalTo: whyImageView.bottomAnchor, constant: 72),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: buttonView.topAnchor, constant: -100),
            
            buttonView.heightAnchor.constraint(equalToConstant: 50),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            
            authView.heightAnchor.constraint(equalToConstant: 476),
            authView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            authView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            authView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            blurEffectView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewWillLayoutSubviews() {
        authView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
    }
    
    @objc private func buttonViewTapped() {
        blurEffectView.isHidden = false
        authView.isHidden = false
    }
    
    @objc private func exitButtonTapped() {
        blurEffectView.isHidden = true
        authView.isHidden = true
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            break
        case .changed:
            handlePanChangedState(gesture: gesture)
        case .ended:
            handlePanEndedState(gesture: gesture)
        default:
            break
        }
    }
    
    //MARK: HANDLE PAN GESTURES
    private func handlePanChangedState(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        if translation.y > 0 {
            self.authView.transform = CGAffineTransform(translationX: 0, y: translation.y)
            let newAlpha = 1 + translation.y / -200
            self.authView.alpha = newAlpha < 0 ? 0 : newAlpha
            self.blurEffectView.alpha = newAlpha < 0 ? 0 : newAlpha
        }
    }
    
    private func handlePanEndedState(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.authView.transform = .identity
            if translation.y > 100 {
                self.authView.isHidden = true
                self.blurEffectView.isHidden = true
            }
            self.authView.alpha = 1
            self.blurEffectView.alpha = 1
        })
    }
}

