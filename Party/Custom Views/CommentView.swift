//
//  CommentView.swift
//  Party
//
//  Created by Александр Цветков on 27.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class CommentView: UIView {
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.backgroundBlack.getValue()
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let partyImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "eventImage")
        view.layer.cornerRadius = 155 / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "LV_party"
        view.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let ratingView: RatingView = {
        let view = RatingView(withRating: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let commentTextFieldView: TextFieldView = {
        let view = TextFieldView(text: "", placeholder: "Комментарий")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let backButtonView: ButtonView = {
        let view = ButtonView(color: Colors.pink.getValue(), title: "Назад", left: 16, right: 16)
        view.changeIcon(newImageName: "backIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    convenience init() {
        self.init(frame: .zero)
        self.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(backButtonViewTapped))
        backButtonView.addGestureRecognizer(tap)
    }

    private func setupViews() {
        addSubview(backView)
        backView.addSubview(partyImageView)
        backView.addSubview(titleLabel)
        backView.addSubview(ratingView)
        backView.addSubview(commentTextFieldView)
        backView.addSubview(backButtonView)
        
        NSLayoutConstraint.activate([
            backView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.66),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            partyImageView.centerYAnchor.constraint(equalTo: backView.topAnchor),
            partyImageView.heightAnchor.constraint(equalToConstant: 155),
            partyImageView.widthAnchor.constraint(equalToConstant: 155),
            partyImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: partyImageView.bottomAnchor, constant: 50),
            titleLabel.bottomAnchor.constraint(equalTo: ratingView.topAnchor, constant: -20),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            ratingView.heightAnchor.constraint(equalToConstant: 23),
            ratingView.widthAnchor.constraint(equalToConstant: 152),
            ratingView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            commentTextFieldView.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 52.5),
            commentTextFieldView.bottomAnchor.constraint(equalTo: backButtonView.topAnchor, constant: -75),
            commentTextFieldView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            commentTextFieldView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            backButtonView.heightAnchor.constraint(equalToConstant: 50),
            backButtonView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            backButtonView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backButtonView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    @objc private func backButtonViewTapped() {
        self.isHidden = true
    }
}
