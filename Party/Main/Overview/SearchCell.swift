//
//  SearchCell.swift
//  Party
//
//  Created by Александр Цветков on 17.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    static let reuseId = "SearchCell"
    
    //MARK: - Subviews
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .white
        view.text = "LV_party"
        view.font = UIFont(name: "SFProText-Semibold", size: 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let timeIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "timeIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let timeLabel: UILabel = {
        let view = UILabel()
        view.text = "Сегодня в 22:00"
        view.textAlignment = .left
        view.textColor = Colors.gray.getValue()
        view.font = UIFont(name: "SFProText-Medium", size: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let djLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .white
        view.text = "DJ"
        view.font = UIFont(name: "SFProText-Medium", size: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let djNameLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = Colors.gray.getValue()
        view.font = UIFont(name: "SFProText-Medium", size: 12)
        view.text = "Mironov, Aver"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let partyImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "eventImage")
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = Colors.cellBackground.getValue()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    private let likeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = Colors.pink.getValue()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let likeImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "heartIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Properties
    private lazy var pan = UIPanGestureRecognizer(target: self, action: #selector(cellDragged))
    private var likeIsShowing = false
    private var previousTranslation: CGFloat = 0
    
    //MARK: - Configure
    func configure() {
        backgroundColor = .clear
        selectionStyle = .none
        setupSubviews()
        backView.addGestureRecognizer(pan)
    }
    
    //MARK: - Setup
    private func setupSubviews() {
        addSubview(likeView)
        addSubview(likeImageView)
        addSubview(backView)
        backView.addSubview(titleLabel)
        backView.addSubview(timeIcon)
        backView.addSubview(timeLabel)
        backView.addSubview(djLabel)
        backView.addSubview(djNameLabel)
        backView.addSubview(partyImage)
        
        NSLayoutConstraint.activate([
            likeView.topAnchor.constraint(equalTo: self.topAnchor),
            likeView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            likeView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            likeView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            likeImageView.centerYAnchor.constraint(equalTo: likeView.centerYAnchor),
            likeImageView.heightAnchor.constraint(equalToConstant: 25),
            likeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 21.5),
            likeImageView.widthAnchor.constraint(equalToConstant: 27),
            
            backView.topAnchor.constraint(equalTo: self.topAnchor),
            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            partyImage.heightAnchor.constraint(equalToConstant: 90),
            partyImage.widthAnchor.constraint(equalToConstant: 90),
            partyImage.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            partyImage.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -7),
            
            titleLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 14),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: partyImage.leadingAnchor, constant: -20),
            
            timeIcon.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 17.5),
            timeIcon.heightAnchor.constraint(equalToConstant: 14),
            timeIcon.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 13.5),
            timeIcon.widthAnchor.constraint(equalToConstant: 14),
            
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 17),
            timeLabel.heightAnchor.constraint(equalToConstant: 14),
            timeLabel.leadingAnchor.constraint(equalTo: timeIcon.trailingAnchor, constant: 7.5),
            timeLabel.trailingAnchor.constraint(lessThanOrEqualTo: partyImage.leadingAnchor, constant: -20),
            
            djLabel.topAnchor.constraint(equalTo: timeIcon.bottomAnchor, constant: 8),
            djLabel.heightAnchor.constraint(equalToConstant: 14),
            djLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12),
            djLabel.trailingAnchor.constraint(equalTo: djNameLabel.leadingAnchor, constant: -6),
            
            djNameLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            djNameLabel.heightAnchor.constraint(equalToConstant: 11),
            djNameLabel.leadingAnchor.constraint(equalTo: djLabel.trailingAnchor, constant: 6),
            djNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: partyImage.leadingAnchor, constant: -20),
        ])
    }
    
    //MARK: - Pan gesture handling
    @objc private func cellDragged() {
        switch pan.state {
        case .began:
            handleStartDragging()
        case .changed:
            handleDragging()
        case .ended:
            handleEndDragging()
        default:
            break
        }
        previousTranslation = pan.translation(in: backView).x
    }
    
    private func handleStartDragging() {
        
    }
    
    private func handleDragging() {
        let translationX = pan.translation(in: backView).x
        print(translationX)
        if translationX >= 0 && !likeIsShowing {
            let newTranslationX = translationX > 70 ? 70 : translationX
            //backView.center.x = newTranslationX + self.center.x
            backView.transform = CGAffineTransform(translationX: newTranslationX, y: 0)
        } else if translationX <= 0 && translationX >= -70 && likeIsShowing {
            let newTranslationX = translationX < -70 ? -70 : translationX
            //backView.center.x = newTranslationX + self.center.x + 70
            backView.transform = CGAffineTransform(translationX: newTranslationX + 70, y: 0)
        }
    }
    
    private func handleEndDragging() {
        let translationX = pan.translation(in: backView).x
        if translationX >= 35 {
            //backView.center.x  = 70 + self.center.x
            backView.transform = .identity
            backView.transform = CGAffineTransform(translationX: 70, y: 0)
            likeIsShowing = true
        } else {
            //backView.center.x  = self.center.x
            backView.transform = .identity
            likeIsShowing = false
        }
    }
}
