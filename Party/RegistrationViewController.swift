//
//  RegistrationViewController.swift
//  Party
//
//  Created by Александр Цветков on 16.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class RegistrationViewController: UIViewController {
    
    var delegate: OnboardingViewController!
    private let label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        view.text = "Регистрация"
        view.textColor = .white
        return view
    }()
    private let floatingTextField: SkyFloatingLabelTextField = {
        let view = SkyFloatingLabelTextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "+7"
        view.placeholder = "Мой телефон"
        view.font = UIFont(name: "SFProText-Regular", size: 17)
        view.lineHeight = 0
        view.selectedLineHeight = 0
        view.titleFont = UIFont(name: "SFProText-Regular", size: 12) ?? UIFont.systemFont(ofSize: 33)
        view.tintColor = UIColor(hex: "FFFFFF", alpha: 0.65)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(hex: "FFFFFF", alpha: 0.65)
        view.titleColor = Colors.pink.getValue()
        view.selectedTitleColor = Colors.pink.getValue()
        view.errorColor = Colors.red.getValue()
        view.keyboardAppearance = .dark
        view.keyboardType = .numberPad
        return view
    }()
    private let textFieldBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Colors.textFieldBorder.getValue().cgColor
        view.layer.cornerRadius = 10
        view.backgroundColor = Colors.textFieldBackground.getValue()
        return view
    }()
    private let timerLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "SFProText-Regular", size: 17)
        view.textAlignment = .left
        view.text = "Осталось"
        view.textColor = Colors.gray.getValue()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let timeLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "SFProDisplay-Regular", size: 28)
        view.textAlignment = .left
        view.text = "00:59"
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(image: UIImage(named: "whyBackButton"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = newBackButton
        floatingTextField.delegate = self
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(label)
        view.addSubview(textFieldBackgroundView)
        view.addSubview(floatingTextField)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.heightAnchor.constraint(equalToConstant: 40),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 14),
            
            floatingTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 60),
            floatingTextField.leadingAnchor.constraint(equalTo: textFieldBackgroundView.leadingAnchor, constant: 14),
            floatingTextField.trailingAnchor.constraint(equalTo: textFieldBackgroundView.trailingAnchor, constant: -14),
            
            textFieldBackgroundView.topAnchor.constraint(equalTo: floatingTextField.topAnchor, constant: -18),
            textFieldBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textFieldBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textFieldBackgroundView.bottomAnchor.constraint(equalTo: floatingTextField.bottomAnchor, constant: 14),
            textFieldBackgroundView.heightAnchor.constraint(equalToConstant: 74)
        ])
    }
    
    @objc private func backButtonTapped() {
        delegate.blurEffectView.isHidden = true
        delegate.authView.isHidden = true
        delegate.authView.transform = .identity
        delegate.authViewIsVisibleConstraint.isActive = false
        delegate.authViewIsHiddenConstraint.isActive = true
        navigationController?.navigationBar.isHidden = true
        navigationController?.popViewController(animated: true)
    }

}

extension RegistrationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text == "+" && string.isEmpty {
            return false
        } else if textField.text?.count == 12 && !string.isEmpty{
            return false
        } else {
            return true
        }
    }
}
