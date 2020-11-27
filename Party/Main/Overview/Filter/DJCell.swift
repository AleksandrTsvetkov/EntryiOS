//
//  DJCell.swift
//  Party
//
//  Created by Александр Цветков on 27.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class DJCell: UITableViewCell {

    static let reuseId = "DJCell"
    private let djIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "djIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let djLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.text = "DJ"
        view.textColor = .white
        view.font = UIFont(name: "SFProText-Semibold", size: 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let djTextView: UITextView = {
        let view = UITextView()
        view.font = UIFont(name: "SFProText-Regular", size: 17)
        view.textAlignment = .left
        view.text = "Введите имя диджея..."
        view.textColor = UIColor.white.withAlphaComponent(0.65)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    func configure() {
        backgroundColor = .clear
        selectionStyle = .none
        
        setupViews()
    }
    
    private func setupViews() {
        addSubview(djIcon)
        addSubview(djLabel)
        addSubview(djTextView)
        
        NSLayoutConstraint.activate([
            djIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 51.5),
            djIcon.heightAnchor.constraint(equalToConstant: 17),
            djIcon.widthAnchor.constraint(equalToConstant: 17),
            djIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),

            djLabel.centerYAnchor.constraint(equalTo: djIcon.centerYAnchor),
            djLabel.heightAnchor.constraint(equalToConstant: 20),
            djLabel.leadingAnchor.constraint(equalTo: djIcon.trailingAnchor, constant: 6),
            djLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20),

            djTextView.topAnchor.constraint(equalTo: djLabel.bottomAnchor, constant: 25),
            djTextView.heightAnchor.constraint(equalToConstant: 60),
            djTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            djTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

        ])
    }

}
