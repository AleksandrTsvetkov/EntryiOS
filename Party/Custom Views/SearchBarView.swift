//
//  SearchBarView.swift
//  Party
//
//  Created by Александр Цветков on 20.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class SearchBarView: UIView {
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.searchBarBackground.getValue()
        view.layer.cornerRadius = 18
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var textField: UITextField = {
        let view = UITextField()
        view.keyboardAppearance = .dark
        view.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        view.autocorrectionType = .no
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "SFProText-Regular", size: 17)
        view.textColor = Colors.gray.getValue().withAlphaComponent(1)
        return view
    }()
    private lazy var searchIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "searchIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let button: UIButton = {
        let view = UIButton(type: .custom)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return view
    }()
    private let buttonBackView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.searchBarBackground.getValue()
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var delegate: SearchBarViewDelegate?
    private var searchBarType: SearchBarType = .withFilter
    private lazy var textFieldLeftSpaceConstraint = textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 35)
    private let attributes: Dictionary<NSAttributedString.Key, NSObject> = {
        let font = UIFont(name: "SFProText-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)
        let color = Colors.gray.getValue()
        return [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color]
    }()
    

    convenience init(ofType type: SearchBarType, withDelegate delegateVC: SearchBarViewDelegate) {
        self.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        delegate = delegateVC
        textField.delegate = delegateVC
        searchBarType = type
        
        switch type {
        case .withFilter:
            button.setImage(UIImage(named: "filterIcon"), for: .normal)
            textField.attributedPlaceholder = NSAttributedString(string: "Поиск", attributes: attributes)
            textFieldLeftSpaceConstraint.constant = 35
            searchIcon.isHidden = false
        case .withResults:
            button.setImage(UIImage(named: "closeIcon"), for: .normal)
            textField.attributedPlaceholder = NSAttributedString(string: "Введите запрос", attributes: attributes)
            textFieldLeftSpaceConstraint.constant = 15
            searchIcon.isHidden = true
        }
        setupViews()
    }
    
    private func setupViews() {
        addSubview(backView)
        addSubview(textField)
        addSubview(buttonBackView)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textFieldLeftSpaceConstraint,
            textField.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -18),
            
            backView.topAnchor.constraint(equalTo: self.topAnchor),
            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -16),
            
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 40),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            buttonBackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonBackView.heightAnchor.constraint(equalToConstant: 40),
            buttonBackView.widthAnchor.constraint(equalToConstant: 40),
            buttonBackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        addIcon()
    }
    
    private func addIcon() {
        addSubview(searchIcon)
        
        NSLayoutConstraint.activate([
            searchIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            searchIcon.heightAnchor.constraint(equalToConstant: 16),
            searchIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            searchIcon.widthAnchor.constraint(equalToConstant: 16),
        ])
    }
    
    func clearSearch() {
        textField.text = ""
        textField.resignFirstResponder()
    }
    
    func switchState(to type: SearchBarType) {
        
        if type == .withResults {
            button.setImage(UIImage(named: "closeIcon"), for: .normal)
            textField.attributedPlaceholder = NSAttributedString(string: "Введите запрос", attributes: attributes)
            textFieldLeftSpaceConstraint.constant = 15
            searchIcon.isHidden = true
            searchBarType = .withResults
            return
        }
        if type == .withFilter {
            button.setImage(UIImage(named: "filterIcon"), for: .normal)
            textField.attributedPlaceholder = NSAttributedString(string: "Поиск", attributes: attributes)
            textFieldLeftSpaceConstraint.constant = 35
            searchIcon.isHidden = false
            searchBarType = .withFilter
            return
        }
    }
    
    @objc private func buttonTapped() {
        delegate?.buttonTapped(ofType: searchBarType)
    }

    @objc private func textFieldChanged() {
        delegate?.textFieldChanged(textField: textField)
    }
}

protocol SearchBarViewDelegate: UITextFieldDelegate {
    func textFieldChanged(textField: UITextField)
    func buttonTapped(ofType type: SearchBarType)
}

enum SearchBarType {
    case withFilter
    case withResults
}
