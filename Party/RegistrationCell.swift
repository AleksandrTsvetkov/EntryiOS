//
//  RegistrationCell.swift
//  Party
//
//  Created by Александр Цветков on 17.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class RegistrationCell: UITableViewCell {
    
    static let reuseId = "RegistrationCell"
    var textFieldView = TextFieldView(text: "", placeholder: "")
    var fieldType: FieldType = .name
    var statusDelegate: StatusDelegate?
    
    func configure(withType type: FieldType) {
        fieldType = type
        backgroundColor = .clear
        selectionStyle = .none
        textFieldView.floatingTextField.delegate = self
        textFieldView.floatingTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        switch type {
        case .name:
            textFieldView.setPlaceholder(placeholder: "Имя")
        case .birthDate:
            textFieldView.setPlaceholder(placeholder: "Дата рождения")
        //textFieldView.floatingTextField.isUserInteractionEnabled = false
        case .email:
            textFieldView.setPlaceholder(placeholder: "E-mail")
            textFieldView.configure(withKeyboardType: .emailAddress, textContentType: .emailAddress)
        case .password:
            textFieldView.setPlaceholder(placeholder: "Пароль")
            textFieldView.floatingTextField.isSecureTextEntry = true
        }
        addSubview(textFieldView)
        textFieldView.floatingTextField.placeholderFont = UIFont(name: "SFProText-Regular", size: 17)
        textFieldView.floatingTextField.titleFont = UIFont(name: "SFProText-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)
        
        NSLayoutConstraint.activate([
            textFieldView.topAnchor.constraint(equalTo: self.topAnchor),
            textFieldView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            textFieldView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            textFieldView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
    
    @objc private func textFieldChanged(_ textfield: UITextField) {
        guard
            let textField = textfield as? FloatingField,
            let text = textField.text
            else { return }
        switch fieldType {
        case .name:
            let set = CharacterSet.letters
            var isValid = true
            for i in text {
                if String(i).rangeOfCharacter(from: set) == nil {
                    isValid = false
                }
            }
            if !isValid && !text.isEmpty {
                textField.errorMessage = "Неправильные символы".uppercased()
            } else {
                textField.errorMessage = ""
            }
        case .birthDate:
            break
        case .email:
            let isEmail = text.isEmail()
            textField.errorMessage = (isEmail  || text.isEmpty) ? "" : "Неправильные символы".uppercased()
        case .password:
            break
        }
        guard let index = FieldType.allCases.firstIndex(of: fieldType) else { return }
        let noErrors = (textField.errorMessage == "" || textField.errorMessage == nil)
        if !text.isEmpty && noErrors {
            statusDelegate?.fieldsStatus[index] = true
        }
    } // textFieldChanged
    
    
}

extension RegistrationCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard
            let textField = textField as? FloatingField,
            let text = textField.text
            else { return true }
        let noErrors = (textField.errorMessage == "" || textField.errorMessage == nil)
        if !text.isEmpty && noErrors {
            textField.titleColor = Colors.textFieldCorrect.getValue()
        } else {
            textField.titleColor = Colors.gray.getValue()
        }
        return true
    }
}

enum FieldType: CaseIterable {
    case name
    case birthDate
    case email
    case password
}

protocol StatusDelegate {
    var fieldsStatus: Array<Bool> { get set }
}
