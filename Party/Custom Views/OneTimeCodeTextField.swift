//
//  OneTimeCodeTextField.swift
//  Party
//
//  Created by Александр Цветков on 16.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class OneTimeCodeTextField: UITextField {
    
    var didEnterDigit: ((String) -> Void)?
    var labels: Array<UILabel> = []
    var amountOfDigitsNow: Int = 0
    
    convenience init() {
        self.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        tintColor = .clear
        backgroundColor = .clear
        textColor = .clear
        keyboardType = .numberPad
        keyboardAppearance = .dark
        textContentType = .oneTimeCode
        
        let labelsStackView = createLabelsStackView()
        addSubview(labelsStackView)
        
        delegate = self
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: self.topAnchor),
            labelsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func createLabelsStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        for _ in 0...3 {
            let label = UILabel()
            label.isUserInteractionEnabled = true
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.font = UIFont(name: "SFProDisplay-Bold", size: 28)
            label.text = "—"
            label.textColor = UIColor(hex: "EBEBF5", alpha: 0.3)
            
            NSLayoutConstraint.activate([
                label.heightAnchor.constraint(equalToConstant: 36),
                label.widthAnchor.constraint(equalToConstant: 20)
            ])
            
            stackView.addArrangedSubview(label)
            labels.append(label)
        }
        return stackView
    }
    
    @objc private func labelTapped() {
        
    }
    
    @objc func textDidChange() {
        guard let text = self.text, text.count <= labels.count else { return }
        amountOfDigitsNow = text.count
        for i in 0..<labels.count {
            let currentLabel = labels[i]
            
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                currentLabel.textColor = .white
                currentLabel.text = String(text[index])
            } else {
                currentLabel.textColor = UIColor(hex: "EBEBF5", alpha: 0.3)
                currentLabel.text = "—"
            }
        }
            didEnterDigit?(text)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OneTimeCodeTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let characterCount = textField.text?.count else { return false }
        return characterCount < labels.count || string == ""
    }
}
