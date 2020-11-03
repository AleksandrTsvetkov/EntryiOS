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
    var picker = UIPickerView()
    
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
            textFieldView.floatingTextField.isUserInteractionEnabled = false
            let tap = UITapGestureRecognizer(target: self, action: #selector(openDatePicker))
            self.addGestureRecognizer(tap)
        case .email:
            textFieldView.setPlaceholder(placeholder: "E-mail")
            textFieldView.configure(withKeyboardType: .emailAddress, textContentType: nil)
            textFieldView.floatingTextField.autocorrectionType = .no
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
    
    @objc private func openDatePicker() {
        statusDelegate?.presentPicker(picker)
    }
    
    @objc private func textFieldChanged(_ textfield: UITextField) {
        guard
            let textField = textfield as? FloatingField,
            let text = textField.text
            else { return }
        switch fieldType {
        case .name:
            var set = CharacterSet.letters
            set.insert(" ")
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
        let noErrors = (textField.errorMessage == "" || textField.errorMessage == nil)
        if !text.isEmpty && noErrors {
            textField.titleColor = Colors.textFieldCorrect.getValue()
        } else {
            textField.titleColor = Colors.gray.getValue()
        }
        guard let index = FieldType.allCases.firstIndex(of: fieldType) else { return }
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let item = textField.inputAssistantItem
        item.leadingBarButtonGroups = []
        item.trailingBarButtonGroups = []
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard
            let textField = textField as? FloatingField,
            let text = textField.text
            else { return true }
        if string == " " && text.count == 0 {
            return false
        }
        if text.contains(" ") && string == " " {
            return false
        } else {
            return true
        }
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
    func presentPicker(_ pickerView: UIPickerView)
}
