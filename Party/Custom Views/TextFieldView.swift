//
//  TextFieldView.swift
//  Party
//
//  Created by Александр Цветков on 16.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class TextFieldView: UITextField {

    private let textFieldBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Colors.textFieldBorder.getValue().cgColor
        view.layer.cornerRadius = 10
        view.backgroundColor = Colors.textFieldBackground.getValue()
        return view
    }()
    let floatingTextField: SkyFloatingLabelTextField = {
        let view = SkyFloatingLabelTextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "SFProText-Regular", size: 17)
        view.lineHeight = 0
        view.selectedLineHeight = 0
        view.titleFont = UIFont(name: "SFProText-Regular", size: 12) ?? UIFont.systemFont(ofSize: 33)
        view.tintColor = UIColor(hex: "FFFFFF", alpha: 0.65)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(hex: "FFFFFF", alpha: 0.65)
        view.titleColor = Colors.gray.getValue()
        view.selectedTitleColor = Colors.pink.getValue()
        view.errorColor = Colors.red.getValue()
        view.keyboardAppearance = .dark
        view.keyboardType = .namePhonePad
        view.autocorrectionType = .yes
        view.textContentType = .telephoneNumber
        return view
    }()
    
    convenience init(text: String, placeholder: String) {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        floatingTextField.text = text
        floatingTextField.placeholder = placeholder
        setupViews()
    }
    
    private func setupViews() {
        addSubview(textFieldBackgroundView)
        addSubview(floatingTextField)
        
        NSLayoutConstraint.activate([
            textFieldBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            textFieldBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textFieldBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textFieldBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            floatingTextField.topAnchor.constraint(equalTo: textFieldBackgroundView.topAnchor, constant: 18),
            floatingTextField.bottomAnchor.constraint(equalTo: textFieldBackgroundView.bottomAnchor, constant: -14),
            floatingTextField.leadingAnchor.constraint(equalTo: textFieldBackgroundView.leadingAnchor, constant: 14),
            floatingTextField.trailingAnchor.constraint(equalTo: textFieldBackgroundView.trailingAnchor, constant: -14),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}
