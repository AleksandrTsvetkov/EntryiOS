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
        label.textAlignment = .left
        let height = UIScreen.main.bounds.height
        let fontSize: CGFloat = height < 740 ? 20 : 22
        label.font = UIFont(name: "SFProDisplay-Bold", size: fontSize)
        label.textColor = .white
        label.text = "Как вы хотите продолжить?"
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
            label.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -33),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
        ])
        
//        if UIScreen.main.bounds.height < 740 {
//            NSLayoutConstraint.activate([
//
//            ])
//        } else {
//            NSLayoutConstraint.activate([
//
//            ])
//        }
    }
    
    @objc private func authTapped(sender: UITapGestureRecognizer) {
        guard let button = sender.view as? AuthTypeView else { return }
        delegate.authTapped(tag: button.tag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
