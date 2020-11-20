//
//  OverviewCell.swift
//  Party
//
//  Created by Александр Цветков on 17.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class OverviewCell: UICollectionViewCell {

    static let reuseId = "OverviewCell"
    private let partyImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "partyImage")
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .white
        view.text = "LV_party"
        view.font = UIFont(name: "SFProText-Semibold", size: 17)
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
        view.textAlignment = .left
        view.text = "Сегодня в 22:00"
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
    
    func configure() {
        layer.cornerRadius = 10
        backgroundColor = Colors.overViewCellBack.getValue()
        setupViews()
    }
    
    private func setupViews() {
        addSubview(partyImage)
        addSubview(titleLabel)
        addSubview(timeIcon)
        addSubview(timeLabel)
        addSubview(djLabel)
        addSubview(djNameLabel)
        
        NSLayoutConstraint.activate([
            partyImage.topAnchor.constraint(equalTo: self.topAnchor),
            partyImage.heightAnchor.constraint(equalToConstant: 150),
            partyImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            partyImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: partyImage.bottomAnchor, constant: -11),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            timeIcon.topAnchor.constraint(equalTo: partyImage.bottomAnchor, constant: 12),
            timeIcon.heightAnchor.constraint(equalToConstant: 12),
            timeIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 11.5),
            timeIcon.widthAnchor.constraint(equalToConstant: 12),
            
            djLabel.topAnchor.constraint(equalTo: timeIcon.bottomAnchor, constant: 8),
            djLabel.heightAnchor.constraint(equalToConstant: 14),
            djLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 11.5),
            djLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
            timeLabel.topAnchor.constraint(equalTo: partyImage.bottomAnchor, constant: 11),
            timeLabel.bottomAnchor.constraint(equalTo: djNameLabel.topAnchor, constant: -8),
            timeLabel.leadingAnchor.constraint(equalTo: timeIcon.trailingAnchor, constant: 7.5),
            timeLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20),
            
            djNameLabel.heightAnchor.constraint(equalToConstant: 14),
            djNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            djNameLabel.leadingAnchor.constraint(equalTo: djLabel.trailingAnchor, constant: 6),
            djNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20),
        ])
    }
}
