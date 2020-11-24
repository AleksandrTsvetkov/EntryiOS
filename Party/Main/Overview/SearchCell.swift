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
        return view
    }()
    
    func configure() {
        backgroundColor = .clear
        selectionStyle = .none
        setupViews()
    }
    
    private func setupViews() {
        addSubview(backView)
        addSubview(titleLabel)
        addSubview(timeIcon)
        addSubview(timeLabel)
        addSubview(djLabel)
        addSubview(djNameLabel)
        addSubview(partyImage)
        
        NSLayoutConstraint.activate([
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
}
