//
//  WhereEventCell.swift
//  Party
//
//  Created by Александр Цветков on 03.12.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class WhereEventCell: TableViewCell {

    //MARK: - Subviews
    private let icon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "whereIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .white
        view.font = UIFont(name: "SFProDisplay-Bold", size: 17)
        view.text = "Где?"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let infoTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .clear
        view.isEditable = false
        view.isScrollEnabled = false
        view.textColor = Colors.gray.getValue()
        view.font = UIFont(name: "SFProText-Regular", size: 17)
        view.textAlignment = .left
        view.textContainer.lineBreakMode = .byWordWrapping
        view.text = "Невский проспект, дом 10, Санкт-Петербург"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let mapView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.image = UIImage(named: "mapSmallPlaceholder")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Configure
    override func configure() {
        super.configure()
        
        setupSubviews()
    }

    //MARK: - Setup
    private func setupSubviews() {
        addSubview(icon)
        addSubview(titleLabel)
        addSubview(infoTextView)
        addSubview(mapView)
        
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: self.topAnchor),
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17.5),
            icon.heightAnchor.constraint(equalToConstant: 18),
            icon.widthAnchor.constraint(equalToConstant: 18),
            
            titleLabel.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            titleLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 6),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20),
            
            infoTextView.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 15),
            infoTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -33),
            infoTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            infoTextView.trailingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: -16),
            
            mapView.topAnchor.constraint(equalTo: infoTextView.topAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 120),
            mapView.widthAnchor.constraint(equalToConstant: 120),
            mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
}
