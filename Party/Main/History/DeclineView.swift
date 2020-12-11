//
//  DeclineView.swift
//  Party
//
//  Created by Александр Цветков on 30.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class DeclineView: UIView {

    //MARK: - Subviews
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.contentView.layer.cornerRadius = 20
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let closeButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(UIImage(named: "exit"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let sadImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "sadImage")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        view.textAlignment = .center
        view.text = "LV_party"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let textLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 0
        view.font = UIFont(name: "SFProText-Regular", size: 15)
        view.text = "К сожалению, ваша заявка была\nотклонена, вся сумма будет возвращена в\n течение недели."
        view.textColor = UIColor.white.withAlphaComponent(0.65)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let searchButtonView: ButtonView = {
        let view = ButtonView(color: Colors.pink.getValue(), title: "Найти другое событие", left: 16, right: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(close))
        searchButtonView.addGestureRecognizer(tap)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    private func setupViews() {
        addSubview(blurEffectView)
        addSubview(closeButton)
        addSubview(sadImageView)
        addSubview(titleLabel)
        addSubview(textLabel)
        addSubview(searchButtonView)

        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: self.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            sadImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 92),
            sadImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            sadImageView.widthAnchor.constraint(equalToConstant: 120),
            sadImageView.heightAnchor.constraint(equalToConstant: 158),
            
            titleLabel.topAnchor.constraint(equalTo: sadImageView.bottomAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -10),
            
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 5),
            textLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -5),
            textLabel.bottomAnchor.constraint(lessThanOrEqualTo: searchButtonView.topAnchor, constant: -20),
            
            searchButtonView.heightAnchor.constraint(equalToConstant: 50),
            searchButtonView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            searchButtonView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchButtonView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    //MARK: - Objc methods
    @objc private func close() {
        isHidden = true
    }
}
