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
    let authView = AuthView()
    let blurEffectView1: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let blurEffectView2: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var authViewIsHiddenConstraint: NSLayoutConstraint!
    var authViewIsVisibleConstraint: NSLayoutConstraint!
    
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
        view.addSubview(blurEffectView1)
        view.addSubview(blurEffectView2)
        view.addSubview(authView)
        authView.isHidden = true
        authView.delegate = self
        
        authViewIsHiddenConstraint = authView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 500)
        authViewIsVisibleConstraint = authView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([
            
            exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            exitButton.heightAnchor.constraint(equalToConstant: 30),
            exitButton.widthAnchor.constraint(equalToConstant: 30),
            
            whyImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            whyImageView.heightAnchor.constraint(equalToConstant: 36),
            whyImageView.widthAnchor.constraint(equalToConstant: 186),
            
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            buttonView.heightAnchor.constraint(equalToConstant: 50),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            authView.heightAnchor.constraint(equalToConstant: 500),
            authView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            authView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            authViewIsHiddenConstraint,
            
            blurEffectView1.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurEffectView1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView1.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        if UIScreen.main.bounds.height < 740 {
            NSLayoutConstraint.activate([
                exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 34),
                whyImageView.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 20),
                stackView.topAnchor.constraint(equalTo: whyImageView.bottomAnchor, constant: 42),
                stackView.bottomAnchor.constraint(lessThanOrEqualTo: buttonView.topAnchor, constant: -44),
                buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            ])
        } else {
            NSLayoutConstraint.activate([
                exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
                whyImageView.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 41),
                stackView.topAnchor.constraint(equalTo: whyImageView.bottomAnchor, constant: 72),
                stackView.bottomAnchor.constraint(lessThanOrEqualTo: buttonView.topAnchor, constant: -100),
                buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            ])
        }
    }
    
    override func viewWillLayoutSubviews() {
        authView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        navigationController?.navigationBar.isHidden = true
        
    }
    
    @objc private func buttonViewTapped() {
        blurEffectView1.isHidden = false
        blurEffectView2.isHidden = false
        authView.isHidden = false
        self.authViewIsHiddenConstraint.isActive = false
        self.authViewIsVisibleConstraint.isActive = true
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc private func exitButtonTapped() {
        blurEffectView1.isHidden = true
        blurEffectView2.isHidden = true
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
            let newAlpha = 1 + translation.y / -120
            self.blurEffectView1.alpha = newAlpha < 0 ? 0 : newAlpha
            self.blurEffectView2.alpha = newAlpha < 0 ? 0 : newAlpha
        }
    }
    
    private func handlePanEndedState(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        if translation.y > 120 {
            self.authViewIsVisibleConstraint.isActive = false
            self.authViewIsHiddenConstraint.isActive = true
        }
        if translation.y > 120 {
            UIView.animate(withDuration: 0.4, animations: {
                self.view.layoutIfNeeded()
                self.authView.transform = .identity
            }, completion: { _ in
                self.authView.isHidden = true
                self.blurEffectView1.isHidden = true
                self.blurEffectView2.isHidden = true
                self.blurEffectView1.alpha = 1
                self.blurEffectView2.alpha = 1
            })
        }
        self.authView.transform = .identity
    }
}

extension OnboardingViewController: AuthTapDelegate {
    func authTapped(tag: Int) {
        switch tag {
        case 0:
            let vc = SignUpViewController()
            vc.delegate = self
            let backButton = UIBarButtonItem()
            backButton.title = "Зачем?"
            navigationItem.backBarButtonItem = backButton
            navigationController?.navigationBar.isHidden = false
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = LoginViewController()
            vc.delegate = self
            let backButton = UIBarButtonItem()
            backButton.title = "Зачем?"
            navigationItem.backBarButtonItem = backButton
            navigationController?.navigationBar.isHidden = false
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
