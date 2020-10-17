//
//  SignUpViewController.swift
//  Party
//
//  Created by Александр Цветков on 16.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class SignUpViewController: UIViewController {
    
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
        view.isHidden = true
        view.textColor = Colors.gray.getValue()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let timeLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "SFProDisplay-Regular", size: 28)
        view.textAlignment = .left
        view.isHidden = true
        view.text = "00:59"
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let errorLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.isHidden = true
        view.text = "Произошла ошибка!"
        view.textColor = .white
        view.font = UIFont(name: "SFProDisplay-Regular", size: 22)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var timer: Timer?
    private var timerCount: Int = 59
    private lazy var buttonView = ButtonView(color: Colors.pink.getValue(), title: "Дальше", left: 16, right: 16)
    
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
        view.addSubview(timerLabel)
        view.addSubview(timeLabel)
        view.addSubview(buttonView)
        view.addSubview(errorLabel)
        codeTextField.isHidden = true
        textFieldView.floatingTextField.becomeFirstResponder()
        let tap = UITapGestureRecognizer(target: self, action: #selector(buttonViewTapped))
        buttonView.addGestureRecognizer(tap)
        textFieldView.floatingTextField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        codeTextField.didEnterLastDigit = { [weak self] code in
            guard let self = self else { return }
            switch code {
            case "7777":
                self.buttonView.setColor(color: Colors.pink.getValue())
                self.buttonView.setTitle(title: "Дальше")
                self.codeTextField.resignFirstResponder()
            case "6666":
                self.buttonView.setColor(color: Colors.red.getValue())
                self.buttonView.state = .error
                self.errorLabel.isHidden = false
                self.timeLabel.isHidden = true
                self.timerLabel.isHidden = true
                self.codeTextField.resignFirstResponder()
            default:
                break
            }
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
            codeTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 110),
            
            timerLabel.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 127),
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timerLabel.heightAnchor.constraint(equalToConstant: 20),
            
            timeLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 13),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timeLabel.heightAnchor.constraint(equalToConstant: 34),
            
            buttonView.heightAnchor.constraint(equalToConstant: 50),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            
            errorLabel.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 200),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            errorLabel.heightAnchor.constraint(equalToConstant: 28),
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
                        DispatchQueue.main.async {
                            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                                self.timerCount -= 1
                                self.timeLabel.text = "00:\(self.timerCount)"
                                if self.timerCount == 0 {
                                    self.timer?.invalidate()
                                    self.timerCount = 59
                                }
                            })
                        }
                        codeTextField.isHidden = false
                        textFieldView.isHidden = true
                        timerLabel.isHidden = false
                        timeLabel.isHidden = false
                        codeTextField.becomeFirstResponder()
                    }
                }
            }
        }
    }
    
    @objc private func buttonViewTapped() {
        if buttonView.state == .error {
            buttonView.state = .next
            codeTextField.becomeFirstResponder()
            timeLabel.isHidden = false
            timerLabel.isHidden = false
            errorLabel.isHidden = true
            timerCount = 59
            self.timer?.invalidate()
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                self.timerCount -= 1
                self.timeLabel.text = "00:\(self.timerCount)"
                if self.timerCount == 0 {
                    self.timer?.invalidate()
                    self.timerCount = 59
                }
            })
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

extension SignUpViewController: UITextFieldDelegate {
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
