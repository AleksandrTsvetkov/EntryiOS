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
    private let textFieldView = TextFieldView(text: "+7", placeholder: "Мой телефон")
    private let codeTextField = OneTimeCodeTextField()
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
        textFieldView.floatingTextField.delegate = self
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(label)
        view.addSubview(textFieldView)
        view.addSubview(codeTextField)
        codeTextField.isHidden = true
        textFieldView.floatingTextField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        codeTextField.didEnterLastDigit = { [weak self] code in
            guard let _ = self else { return }
            print(code)
        }
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.heightAnchor.constraint(equalToConstant: 40),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 14),
            
            textFieldView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 65),
            textFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textFieldView.heightAnchor.constraint(equalToConstant: 74),
            
            codeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            codeTextField.heightAnchor.constraint(equalToConstant: 36),
            codeTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 110)
        ])
    }
    
    @objc private func textFieldChanged(_ textfield: UITextField) {
        if let text = textfield.text {
            if let floatingLabelTextField = textfield as? SkyFloatingLabelTextField {
                if !String(text.dropFirst()).isNumeric {
                    floatingLabelTextField.errorMessage = "Неправильный номер"
                } else {
                    floatingLabelTextField.errorMessage = ""
                    if text.count == 12 {
                        codeTextField.isHidden = false
                        textFieldView.isHidden = true
                        codeTextField.becomeFirstResponder()
                    }
                }
            }
        }
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
        guard let floatingTextField = textField as? SkyFloatingLabelTextField else { return false }
        if floatingTextField.text == "+" && string.isEmpty {
            return false
        } else if floatingTextField.text?.count == 12 && !string.isEmpty{
            return false
        } else {
            return true
        }
    }
}
