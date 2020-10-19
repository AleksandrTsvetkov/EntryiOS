//
//  AuthTypeView.swift
//  Party
//
//  Created by Александр Цветков on 15.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

protocol AuthTapDelegate: class {
    func authTapped(tag: Int)
}

class AuthView: UIView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        let width = UIScreen.main.bounds.height
        let fontSize: CGFloat = width < 600 ? 20 : 22
        label.font = UIFont(name: "SFProDisplay-Bold", size: fontSize)
        label.textColor = .white
        label.text = "How do you wish to proceed?"
        return label
    }()
    weak var delegate: AuthTapDelegate!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Colors.lightBlack.getValue()
        setupViews()
    }
    
    private func setupViews() {
        let stackView = UIStackView()
        for i in 0...4 {
            let view = AuthTypeView(type: AuthType.allCases[i])
            view.tag = i
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(authTapped(sender:))))
            stackView.addArrangedSubview(view)
        }
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 26),
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -33),
            
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
        ])
        
        if UIScreen.main.bounds.height < 600 {
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 8),
                label.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -8),
            ])
        } else {
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 20),
                label.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -20),
            ])
        }
    }
    
    @objc private func authTapped(sender: UITapGestureRecognizer) {
        guard let button = sender.view as? AuthTypeView else { return }
        delegate.authTapped(tag: button.tag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
