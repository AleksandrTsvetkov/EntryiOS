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
    
    var delegate: OnboardingViewController?
    private let label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        view.text = "Регистрация"
        view.textColor = .white
        return view
    }()
    private let textFieldView = TextFieldView(text: "", placeholder: "МОЙ ТЕЛЕФОН")
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
        view.text = "01:00"
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
    private var timerCount: Int = 60
    private lazy var buttonView = ButtonView(color: Colors.pink.getValue(), title: "Дальше", left: 16, right: 16)
    private var phoneNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        textFieldView.floatingTextField.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(buttonViewTapped))
        buttonView.addGestureRecognizer(tap)
        setupViews()
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if parent == nil {
            delegate?.blurEffectView1.isHidden = true
            delegate?.blurEffectView2.isHidden = true
            delegate?.authView.isHidden = true
            delegate?.authView.transform = .identity
            delegate?.authViewIsVisibleConstraint.isActive = false
            delegate?.authViewIsHiddenConstraint.isActive = true
            if let _ = navigationController?.viewControllers[1] as? LoginViewController {
                navigationController?.navigationBar.isHidden = false
            } else {
                navigationController?.navigationBar.isHidden = true
            }
        }
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
        
        textFieldView.configure(withKeyboardType: .namePhonePad, textContentType: .telephoneNumber)
        textFieldView.setBackgroundColor(color: Colors.textFieldBackgroundResponder.getValue())
        textFieldView.floatingTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        textFieldView.floatingTextField.autocorrectionType = .yes
        textFieldView.floatingTextField.becomeFirstResponder()
        codeTextField.didEnterDigit = { [weak self] code in
            guard let self = self else { return }
            guard self.codeTextField.amountOfDigitsNow == 4 else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                guard self.codeTextField.amountOfDigitsNow == 4 else { return }
                NetworkService.shared.checkCode(phoneNumber: self.phoneNumber, code: code) { result in
                    switch result {
                    case .success(let data):
                        do {
                            self.buttonView.setColor(color: Colors.pink.getValue())
                            self.buttonView.state = .next
                            self.codeTextField.resignFirstResponder()
                            self.timeLabel.isHidden = true
                            self.timerLabel.isHidden = true
                            guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                            print("\(dict) code")
                            if let warning = dict["warning"] as? String {
                                //self.receiveCodeError()
                                //TODO: - Create alert
                                print(warning)
                            }
                            if let error = dict["error"] as? String {
                                //self.receiveCodeError()
                                //TODO: - Create alert
                                print(error)
                            }
                            if let verified = dict["verified"] as? Int {
                                print("verified is \(verified) when checking code")
                                if verified == 0 {
                                    //self.receiveCodeError()
                                    //TODO: - Create alert
                                    print("wrong code")
                                } else if verified == 1 {
//                                    self.buttonView.setColor(color: Colors.pink.getValue())
//                                    self.buttonView.state = .next
//                                    self.codeTextField.resignFirstResponder()
//                                    self.timeLabel.isHidden = true
//                                    self.timerLabel.isHidden = true
                                }
                            }
                        } catch {
                            self.buttonView.setColor(color: Colors.pink.getValue())
                            self.buttonView.state = .next
                            self.codeTextField.resignFirstResponder()
                            self.timeLabel.isHidden = true
                            self.timerLabel.isHidden = true
                            print(error)
                        }

                    case .failure(let error):
                        print(error)
                    }
                } // Check code
            }
        }
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.heightAnchor.constraint(equalToConstant: 40),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 14),
            
            textFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textFieldView.heightAnchor.constraint(equalToConstant: 74),
            
            codeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            codeTextField.heightAnchor.constraint(equalToConstant: 36),
            
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timerLabel.heightAnchor.constraint(equalToConstant: 20),
            
            timeLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 8),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timeLabel.heightAnchor.constraint(equalToConstant: 34),
            
            buttonView.heightAnchor.constraint(equalToConstant: 50),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            errorLabel.heightAnchor.constraint(equalToConstant: 28),
        ])
        
        if UIScreen.main.bounds.height < 740 {
            NSLayoutConstraint.activate([
                textFieldView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
                timerLabel.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 66),
                codeTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50),
                errorLabel.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 50),
            ])
        } else {
            NSLayoutConstraint.activate([
                textFieldView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 65),
                timerLabel.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 127),
                codeTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 110),
                errorLabel.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 160),
            ])
        }
        
    }
    
    @objc private func textFieldChanged(_ textfield: UITextField) {
        guard let text = textfield.text else { return }
        if let floatingLabelTextField = textfield as? SkyFloatingLabelTextField {
            floatingLabelTextField.text = text.trimmingCharacters(in: .whitespaces)
            guard let currentText = floatingLabelTextField.text else { return }
            if !String(currentText.dropFirst()).isNumeric {
                floatingLabelTextField.errorMessage = "НЕПРАВИЛЬНЫЙ НОМЕР".uppercased()
            } else {
                floatingLabelTextField.errorMessage = ""
                if textFieldView.floatingTextField.text?.count == 12 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                        guard self.textFieldView.floatingTextField.text?.count == 12 && String(self.textFieldView.floatingTextField.text?.dropFirst() ?? "").isNumeric else { return }
                        self.phoneNumber = currentText
                        NetworkService.shared.sendCode(phoneNumber: String(currentText.dropFirst())) { result in
                            switch result {
                            case .success(let data):
                                guard let dataString = String(data: data, encoding: .utf8) else { return }
                                print(dataString)
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                        self.timer?.invalidate()
                        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                            switch self.timerCount {
                            case 60:
                                self.timeLabel.text = "01:00"
                            case 0...9:
                                self.timeLabel.text = "00:0\(self.timerCount)"
                            default:
                                self.timeLabel.text = "00:\(self.timerCount)"
                            }
                            self.timerCount -= 1
                            if self.timerCount == 0 {
                                self.timer?.invalidate()
                                self.timerCount = 60
                                self.codeTextField.resignFirstResponder()
                                self.buttonView.setColor(color: Colors.red.getValue())
                                self.buttonView.state = .error
                                self.codeTextField.text = ""
                                self.codeTextField.textDidChange()
                                self.errorLabel.isHidden = false
                                self.timerLabel.isHidden = true
                                self.timeLabel.isHidden = true
                            }
                        })
                        self.codeTextField.isHidden = false
                        self.textFieldView.isHidden = true
                        self.timerLabel.isHidden = false
                        self.timeLabel.isHidden = false
                        self.codeTextField.becomeFirstResponder()
                    } // Dispatch
                }
            }
        }
    } // textFieldChanged
    
    private func receiveCodeError() {
        self.buttonView.setColor(color: Colors.red.getValue())
        self.buttonView.state = .error
        self.errorLabel.isHidden = false
        self.timeLabel.isHidden = true
        self.timerLabel.isHidden = true
        self.codeTextField.text = ""
        self.codeTextField.textDidChange()
        self.codeTextField.resignFirstResponder()
    }
    
    @objc private func buttonViewTapped() {
        if buttonView.state == .error {
            buttonView.setColor(color: Colors.pink.getValue())
            buttonView.state = .next
            codeTextField.becomeFirstResponder()
            timeLabel.isHidden = false
            timerLabel.isHidden = false
            errorLabel.isHidden = true
            timeLabel.text = "01:00"
            timerCount = 60
            self.timer?.invalidate()
            DispatchQueue.main.async {
                self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                    switch self.timerCount {
                    case 60:
                        self.timeLabel.text = "01:00"
                    case 0...9:
                        self.timeLabel.text = "00:0\(self.timerCount)"
                    default:
                        self.timeLabel.text = "00:\(self.timerCount)"
                    }
                    self.timerCount -= 1
                    if self.timerCount == 0 {
                        self.timer?.invalidate()
                        self.timerCount = 60
                        self.codeTextField.resignFirstResponder()
                        self.buttonView.setColor(color: Colors.red.getValue())
                        self.buttonView.state = .error
                        self.codeTextField.text = ""
                        self.codeTextField.textDidChange()
                        self.errorLabel.isHidden = false
                        self.timerLabel.isHidden = true
                        self.timeLabel.isHidden = true
                    }
                })
            }
        } else {
            let vc = RegistrationViewController()
            vc.phoneNumber = phoneNumber
            let backButton = UIBarButtonItem()
            backButton.title = "Телефон"
            navigationItem.backBarButtonItem = backButton
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc private func backButtonTapped() {
        delegate?.blurEffectView1.isHidden = true
        delegate?.blurEffectView2.isHidden = true
        delegate?.authView.isHidden = true
        delegate?.authView.transform = .identity
        delegate?.authViewIsVisibleConstraint.isActive = false
        delegate?.authViewIsHiddenConstraint.isActive = true
        navigationController?.navigationBar.isHidden = true
        navigationController?.popViewController(animated: true)
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let floatingTextField = textField as? SkyFloatingLabelTextField else { return false }
        if floatingTextField.text == "" && string == " " {
            //floatingTextField.text = "+7"
            return true
        }
        if string.count == 13 {
            floatingTextField.text = ""
            return true
        }
        if floatingTextField.text == "" && !string.isEmpty {
            floatingTextField.text = "+7"
            return true
        }
        if floatingTextField.text == "+" && string.isEmpty {
            return false
        } else if floatingTextField.text?.count == 12 && !string.isEmpty{
            return false
        } else {
            return true
        }
    }
}
