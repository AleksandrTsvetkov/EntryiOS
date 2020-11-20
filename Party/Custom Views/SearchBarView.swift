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
    private let textField: UITextField = {
        let view = UITextField()
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

    convenience init(ofType type: SearchBarType, delegate: SearchBarViewDelegate) {
        self.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        searchBarType = type
        let font = UIFont(name: "SFProText-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)
        let color = Colors.gray.getValue()
        let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color]
        
        switch type {
        case .withFilter:
            button.setImage(UIImage(named: "filterIcon"), for: .normal)
            textField.attributedPlaceholder = NSAttributedString(string: "Поиск", attributes: attributes)
            addIcon()
        case .withResults:
            button.setImage(UIImage(named: "closeIcon"), for: .normal)
            textField.attributedPlaceholder = NSAttributedString(string: "Введите запрос", attributes: attributes)
        }
        setupViews()
    }
    
    private func setupViews() {
        addSubview(backView)
        addSubview(textField)
        addSubview(buttonBackView)
        addSubview(button)
        
        let textFieldLeftSpace: CGFloat = searchBarType == .withFilter ? 35 : 15
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textFieldLeftSpace),
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
    
    @objc private func buttonTapped() {
        delegate?.buttonTapped(ofType: searchBarType)
    }

}

protocol SearchBarViewDelegate: UITextFieldDelegate {
    func textFieldChanged(text: String)
    func buttonTapped(ofType type: SearchBarType)
}

enum SearchBarType {
    case withFilter
    case withResults
}
