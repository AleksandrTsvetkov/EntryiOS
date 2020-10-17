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
    private var textFieldView: TextFieldView!
    
    func configure(withType type: FieldType) {
        backgroundColor = .clear
        switch type {
        case .name:
            textFieldView = TextFieldView(text: "", placeholder: "Имя")
        case .birthDate:
            textFieldView = TextFieldView(text: "", placeholder: "Дата рождения")
        case .email:
            textFieldView = TextFieldView(text: "", placeholder: "E-mail")
        case .password:
            textFieldView = TextFieldView(text: "", placeholder: "Пароль")
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
}

enum FieldType: CaseIterable {
    case name
    case birthDate
    case email
    case password
}
