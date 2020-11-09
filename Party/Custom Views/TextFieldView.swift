//
//  TextFieldView.swift
//  Party
//
//  Created by Александр Цветков on 16.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class TextFieldView: UIView, ColorDelegate {
    
    private let textFieldBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.borderWidth = 0.5
//        view.layer.borderColor = Colors.textFieldBorder.getValue().cgColor
        view.layer.cornerRadius = 10
        view.backgroundColor = Colors.textFieldBackgroundNotResponder.getValue()
        return view
    }()
    let floatingTextField: FloatingField = {
        let view = FloatingField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "SFProText-Regular", size: 17)
        view.lineHeight = 0
        view.selectedLineHeight = 0
        view.placeholderFont = UIFont(name: "SFProText-Regular", size: 12)
        view.titleFont = UIFont(name: "SFProText-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
        view.titleFormatter = { $0 }
        view.tintColor = UIColor(hex: "FFFFFF", alpha: 0.65)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(hex: "FFFFFF", alpha: 0.65)
        view.titleColor = Colors.gray.getValue()
        view.selectedTitleColor = Colors.pink.getValue()
        view.errorColor = Colors.red.getValue()
        view.keyboardAppearance = .dark
        view.autocorrectionType = .no
        return view
    }()
    
    convenience init(text: String, placeholder: String) {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        //floatingTextField.leftViewMode = .always
        floatingTextField.colorDelegate = self
        floatingTextField.text = text
        floatingTextField.placeholder = placeholder
        floatingTextField.title = placeholder
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
            floatingTextField.bottomAnchor.constraint(equalTo: textFieldBackgroundView.bottomAnchor, constant: -4),
            floatingTextField.leadingAnchor.constraint(equalTo: textFieldBackgroundView.leadingAnchor, constant: 14),
            floatingTextField.trailingAnchor.constraint(equalTo: textFieldBackgroundView.trailingAnchor, constant: -38),
        ])
    }
    
    func setPlaceholder(placeholder: String) {
        floatingTextField.placeholder = placeholder
        floatingTextField.title = placeholder
    }
    
    func setBackgroundColor(color: UIColor) {
        textFieldBackgroundView.backgroundColor = color
    }
    
    func configure(withKeyboardType keyboardType: UIKeyboardType, textContentType: UITextContentType?) {
        floatingTextField.keyboardType = keyboardType
        if let type = textContentType {
            floatingTextField.textContentType = type
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}

class FloatingField: SkyFloatingLabelTextField {
    
    var onProfileScreen = false
    var colorDelegate: ColorDelegate?
    var topInset: CGFloat = -4
    var bottomInset: CGFloat = 4
    
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: topInset, left: 0, bottom: bottomInset, right: 0))
    }

    override func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: -10, left: 0, bottom: 28, right: 0))
    }
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        if !onProfileScreen { colorDelegate?.setBackgroundColor(color: Colors.textFieldBackgroundResponder.getValue()) }
        topInset = -10
        bottomInset = 28
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        if !onProfileScreen { colorDelegate?.setBackgroundColor(color: Colors.textFieldBackgroundNotResponder.getValue()) }
        topInset = -4
        bottomInset = 4
        return super.resignFirstResponder()
    }
}

protocol ColorDelegate {
    func setBackgroundColor(color: UIColor)
}
