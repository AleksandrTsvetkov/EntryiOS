//
//  CommentView.swift
//  Party
//
//  Created by Александр Цветков on 27.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class CommentView: UIView {
    
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.backgroundBlack.getValue().withAlphaComponent(1)
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let partyImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "eventImage")
        view.layer.cornerRadius = 74
        view.clipsToBounds = true
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
    private let commentTextView: UITextView = {
        let view = UITextView()
        view.isScrollEnabled = false
        view.textContainerInset = UIEdgeInsets(top: 30, left: 10, bottom: 5, right: 10)
        view.keyboardAppearance = .dark
        view.textColor = UIColor.white.withAlphaComponent(0.65)
        view.layer.cornerRadius = 10
        view.backgroundColor = Colors.textFieldBackgroundResponder.getValue()
        view.font = UIFont(name: "SFProText-Regular", size: 15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let commentLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.text = "Комментарий"
        view.textColor = UIColor.white.withAlphaComponent(0.3)
        view.font = UIFont(name: "SFProText-Regular", size: 15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let backButtonView: ButtonView = {
        let view = ButtonView(color: Colors.pink.getValue(), title: "Назад", left: 16, right: 16)
        view.changeIcon(newImageName: "backIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var delegate: CommentViewDelegate?
    lazy var bottomConstraint = backView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 300)
    lazy var commentTextViewHeightConstraint = commentTextView.heightAnchor.constraint(equalToConstant: 80)
    lazy var backButtonViewBottomConstraint = backButtonView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -350)
    
    convenience init(withDelegate commentViewDelegate: CommentViewDelegate) {
        self.init(frame: .zero)
        delegate = commentViewDelegate
        addDismissKeyboardByTap()
        self.isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        //backgroundColor = Colors.backgroundBlack.getValue().withAlphaComponent(1)
        ratingView.delegate = self
        commentTextView.delegate = delegate
        let tap = UITapGestureRecognizer(target: self, action: #selector(backButtonViewTapped))
        backButtonView.addGestureRecognizer(tap)
        setupSubviews()
    }

    private func setupSubviews() {
        addSubview(blurEffectView)
        addSubview(backView)
        backView.addSubview(partyImageView)
        backView.addSubview(titleLabel)
        backView.addSubview(ratingView)
        backView.addSubview(commentTextView)
        backView.addSubview(commentLabel)
        backView.addSubview(backButtonView)
        
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: self.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: backView.topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            backView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.66, constant: 300),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomConstraint,
            
            partyImageView.centerYAnchor.constraint(equalTo: backView.topAnchor),
            partyImageView.heightAnchor.constraint(equalToConstant: 155),
            partyImageView.widthAnchor.constraint(equalToConstant: 155),
            partyImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: partyImageView.bottomAnchor, constant: 50),
            titleLabel.bottomAnchor.constraint(equalTo: ratingView.topAnchor, constant: -20),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            ratingView.heightAnchor.constraint(equalToConstant: 23),
            ratingView.widthAnchor.constraint(equalToConstant: 114),
            ratingView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            commentTextView.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 32.5),
            commentTextViewHeightConstraint,
            commentTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            commentTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            commentLabel.topAnchor.constraint(equalTo: commentTextView.topAnchor, constant: 10),
            commentLabel.heightAnchor.constraint(equalToConstant: 20),
            commentLabel.leadingAnchor.constraint(equalTo: commentTextView.leadingAnchor, constant: 15),
            commentLabel.trailingAnchor.constraint(equalTo: commentTextView.trailingAnchor, constant: -15),
            
            backButtonView.heightAnchor.constraint(equalToConstant: 50),
            backButtonView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backButtonView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backButtonViewBottomConstraint,
        ])
    }
    
    private func checkRating() {
        if ratingView.eventRating != 0.0 || (commentTextView.text != nil && commentTextView.text != "") {
            backButtonView.changeTitle(newTitle: "Сохранить")
        } else {
            backButtonView.changeTitle(newTitle: "Назад")
        }
    }
    
    @objc private func commentTextChanged() {
        checkRating()
    }
    
    @objc private func backButtonViewTapped() {
        delegate?.hideView()
    }
}

//MARK: - RatingDelegate
extension CommentView: RatingDelegate {
    func ratingChanged(newRating: Double) {
        checkRating()
    }
}

protocol CommentViewDelegate: UITextViewDelegate {
    func hideView()
}
